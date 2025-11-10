#!/usr/bin/env python3
"""
T-SQL Security Scanner
Detects potential SQL injection vulnerabilities in stored procedures by analyzing:
1. String variable types (VARCHAR, NVARCHAR, etc.)
2. Dynamic SQL concatenation patterns
3. Execution via EXEC or sp_executesql
"""

import pyodbc
import re
import argparse
from datetime import datetime
from typing import List, Dict, Tuple
from dataclasses import dataclass


@dataclass
class Vulnerability:
    """Represents a potential SQL injection vulnerability"""
    database_name: str
    schema_name: str
    object_name: str
    object_type: str
    line_number: int
    variable_name: str
    variable_type: str
    concatenation_pattern: str
    execution_method: str
    risk_level: str
    code_snippet: str


class TSQLScanner:
    """Scanner for detecting SQL injection vulnerabilities in T-SQL code"""

    # String types in SQL Server
    STRING_TYPES = [
        'VARCHAR', 'NVARCHAR', 'CHAR', 'NCHAR',
        'TEXT', 'NTEXT', 'VARCHAR(MAX)', 'NVARCHAR(MAX)'
    ]

    def __init__(self, connection_string: str):
        """Initialize scanner with database connection string"""
        self.connection_string = connection_string
        self.vulnerabilities: List[Vulnerability] = []

    def connect(self) -> pyodbc.Connection:
        """Establish database connection"""
        try:
            conn = pyodbc.connect(self.connection_string, timeout=30)
            print(f"✓ Connected to database successfully")
            return conn
        except Exception as e:
            raise Exception(f"Failed to connect to database: {str(e)}")

    def get_all_tsql_objects(self, conn: pyodbc.Connection) -> List[Dict]:
        """Retrieve all stored procedures, functions, and triggers"""
        query = """
        SELECT
            DB_NAME() as database_name,
            SCHEMA_NAME(o.schema_id) as schema_name,
            o.name as object_name,
            o.type_desc as object_type,
            m.definition as object_definition
        FROM sys.sql_modules m
        INNER JOIN sys.objects o ON m.object_id = o.object_id
        WHERE o.type IN ('P', 'FN', 'IF', 'TF', 'TR')  -- Procedures, Functions, Triggers
        AND m.definition IS NOT NULL
        ORDER BY o.name
        """

        cursor = conn.cursor()
        cursor.execute(query)

        objects = []
        for row in cursor:
            objects.append({
                'database_name': row.database_name,
                'schema_name': row.schema_name,
                'object_name': row.object_name,
                'object_type': row.object_type,
                'definition': row.object_definition
            })

        cursor.close()
        return objects

    def extract_string_variables(self, code: str) -> List[Tuple[str, str]]:
        """Extract all string variable declarations with their types"""
        variables = []

        # Pattern for DECLARE statements
        # Matches: DECLARE @var VARCHAR(100), @var2 NVARCHAR(MAX), etc.
        pattern = r'DECLARE\s+(@\w+)\s+((?:N)?(?:VAR)?CHAR(?:\((?:MAX|\d+)\))?|(?:N)?TEXT)\b'

        for match in re.finditer(pattern, code, re.IGNORECASE):
            var_name = match.group(1)
            var_type = match.group(2).upper()
            variables.append((var_name, var_type))

        # Also check for parameters in procedure/function definitions
        param_pattern = r'(?:CREATE|ALTER)\s+(?:PROCEDURE|FUNCTION).*?(@\w+)\s+((?:N)?(?:VAR)?CHAR(?:\((?:MAX|\d+)\))?|(?:N)?TEXT)\b'

        for match in re.finditer(param_pattern, code, re.IGNORECASE | re.DOTALL):
            var_name = match.group(1)
            var_type = match.group(2).upper()
            variables.append((var_name, var_type))

        return variables

    def find_dynamic_concatenation(self, code: str, var_name: str) -> List[Tuple[int, str, str]]:
        """
        Find instances where a variable is used in string concatenation for dynamic SQL
        Returns: List of (line_number, concatenation_pattern, execution_method)
        """
        findings = []
        lines = code.split('\n')

        # Look for concatenation patterns
        # Pattern 1: SET @sql = ... + @var + ...
        # Pattern 2: @sql = ... + @var + ...
        # Pattern 3: EXEC(@sql + @var + ...)
        # Pattern 4: sp_executesql @sql + @var

        sql_var_pattern = r'@\w*(?:sql|query|cmd|command|stmt|statement)\w*'

        for i, line in enumerate(lines, 1):
            line_upper = line.upper()

            # Check if line contains the variable
            if var_name.upper() not in line_upper:
                continue

            # Check for concatenation operators
            if '+' in line and var_name in line:
                # Check if this is part of dynamic SQL construction
                if re.search(sql_var_pattern, line, re.IGNORECASE):
                    # Now check if this SQL variable is executed
                    execution_method = self.find_execution_method(code, lines, i)

                    if execution_method:
                        # Extract the concatenation pattern (simplified)
                        pattern = line.strip()
                        findings.append((i, pattern, execution_method))

        return findings

    def find_execution_method(self, full_code: str, lines: List[str], concat_line: int) -> str:
        """
        Determine if the dynamic SQL is executed and how
        Looks forward from the concatenation line
        """
        # Get the SQL variable name from the concatenation line
        sql_var_match = re.search(r'(@\w*(?:sql|query|cmd|command|stmt|statement)\w*)',
                                  lines[concat_line - 1], re.IGNORECASE)

        if not sql_var_match:
            return None

        sql_var = sql_var_match.group(1)

        # Look ahead in the code for execution
        remaining_code = '\n'.join(lines[concat_line:concat_line + 50])  # Check next 50 lines

        # Check for EXEC
        exec_pattern = rf'EXEC(?:UTE)?\s*\(\s*{re.escape(sql_var)}'
        if re.search(exec_pattern, remaining_code, re.IGNORECASE):
            return 'EXEC'

        # Check for sp_executesql
        sp_exec_pattern = rf'(?:EXEC(?:UTE)?\s+)?sp_executesql\s+{re.escape(sql_var)}'
        if re.search(sp_exec_pattern, remaining_code, re.IGNORECASE):
            return 'sp_executesql'

        # Check for direct EXEC (without parentheses)
        direct_exec_pattern = rf'EXEC(?:UTE)?\s+{re.escape(sql_var)}'
        if re.search(direct_exec_pattern, remaining_code, re.IGNORECASE):
            return 'EXEC'

        return None

    def assess_risk_level(self, var_type: str, pattern: str, execution_method: str) -> str:
        """Assess the risk level of the vulnerability"""
        risk_score = 0

        # Higher risk for larger string types
        if 'MAX' in var_type or 'TEXT' in var_type:
            risk_score += 3
        else:
            risk_score += 2

        # Direct EXEC is higher risk than sp_executesql
        if execution_method == 'EXEC':
            risk_score += 3
        elif execution_method == 'sp_executesql':
            risk_score += 1

        # Check for lack of sanitization indicators
        if 'REPLACE' not in pattern.upper() and 'QUOTENAME' not in pattern.upper():
            risk_score += 2

        if risk_score >= 6:
            return 'HIGH'
        elif risk_score >= 4:
            return 'MEDIUM'
        else:
            return 'LOW'

    def scan_object(self, obj: Dict):
        """Scan a single T-SQL object for vulnerabilities"""
        code = obj['definition']

        # Step 1: Find all string variables
        string_vars = self.extract_string_variables(code)

        if not string_vars:
            return

        # Step 2 & 3: Check for dynamic concatenation and execution
        for var_name, var_type in string_vars:
            concatenations = self.find_dynamic_concatenation(code, var_name)

            for line_num, pattern, exec_method in concatenations:
                # Extract code snippet around the vulnerability
                lines = code.split('\n')
                start = max(0, line_num - 3)
                end = min(len(lines), line_num + 2)
                snippet = '\n'.join(f"{start + i + 1}: {lines[start + i]}"
                                   for i in range(end - start))

                risk_level = self.assess_risk_level(var_type, pattern, exec_method)

                vuln = Vulnerability(
                    database_name=obj['database_name'],
                    schema_name=obj['schema_name'],
                    object_name=obj['object_name'],
                    object_type=obj['object_type'],
                    line_number=line_num,
                    variable_name=var_name,
                    variable_type=var_type,
                    concatenation_pattern=pattern,
                    execution_method=exec_method,
                    risk_level=risk_level,
                    code_snippet=snippet
                )

                self.vulnerabilities.append(vuln)

    def scan_database(self):
        """Scan entire database for vulnerabilities"""
        conn = self.connect()

        try:
            print("Retrieving T-SQL objects...")
            objects = self.get_all_tsql_objects(conn)
            print(f"Found {len(objects)} objects to scan")

            print("\nScanning objects for vulnerabilities...")
            for idx, obj in enumerate(objects, 1):
                if idx % 10 == 0:
                    print(f"  Scanned {idx}/{len(objects)} objects...")
                self.scan_object(obj)

            print(f"\n✓ Scan complete. Found {len(self.vulnerabilities)} potential vulnerabilities")

        finally:
            conn.close()

    def generate_html_report(self, output_file: str = 'tsql_scan_report.html'):
        """Generate HTML report of findings"""

        # Group vulnerabilities by risk level
        high_risk = [v for v in self.vulnerabilities if v.risk_level == 'HIGH']
        medium_risk = [v for v in self.vulnerabilities if v.risk_level == 'MEDIUM']
        low_risk = [v for v in self.vulnerabilities if v.risk_level == 'LOW']

        html = f"""<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>T-SQL Security Scan Report</title>
    <style>
        * {{
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }}

        body {{
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            padding: 20px;
            line-height: 1.6;
        }}

        .container {{
            max-width: 1400px;
            margin: 0 auto;
            background: white;
            border-radius: 10px;
            box-shadow: 0 10px 40px rgba(0,0,0,0.3);
            overflow: hidden;
        }}

        .header {{
            background: linear-gradient(135deg, #2c3e50 0%, #34495e 100%);
            color: white;
            padding: 40px;
            text-align: center;
        }}

        .header h1 {{
            font-size: 2.5em;
            margin-bottom: 10px;
        }}

        .header .subtitle {{
            font-size: 1.1em;
            opacity: 0.9;
        }}

        .summary {{
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
            padding: 30px;
            background: #f8f9fa;
        }}

        .summary-card {{
            background: white;
            padding: 25px;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            text-align: center;
            border-left: 4px solid #3498db;
        }}

        .summary-card.high {{ border-left-color: #e74c3c; }}
        .summary-card.medium {{ border-left-color: #f39c12; }}
        .summary-card.low {{ border-left-color: #27ae60; }}

        .summary-card .number {{
            font-size: 3em;
            font-weight: bold;
            color: #2c3e50;
        }}

        .summary-card .label {{
            color: #7f8c8d;
            font-size: 1.1em;
            margin-top: 10px;
        }}

        .content {{
            padding: 30px;
        }}

        .section {{
            margin-bottom: 40px;
        }}

        .section-header {{
            display: flex;
            align-items: center;
            margin-bottom: 20px;
            padding-bottom: 10px;
            border-bottom: 3px solid #ecf0f1;
        }}

        .section-header h2 {{
            font-size: 1.8em;
            color: #2c3e50;
        }}

        .risk-badge {{
            display: inline-block;
            padding: 5px 15px;
            border-radius: 20px;
            font-weight: bold;
            font-size: 0.9em;
            margin-left: 15px;
        }}

        .risk-badge.high {{
            background: #e74c3c;
            color: white;
        }}

        .risk-badge.medium {{
            background: #f39c12;
            color: white;
        }}

        .risk-badge.low {{
            background: #27ae60;
            color: white;
        }}

        .vulnerability {{
            background: white;
            border: 1px solid #e0e0e0;
            border-left: 5px solid #3498db;
            border-radius: 5px;
            padding: 20px;
            margin-bottom: 20px;
            transition: transform 0.2s, box-shadow 0.2s;
        }}

        .vulnerability:hover {{
            transform: translateY(-2px);
            box-shadow: 0 5px 20px rgba(0,0,0,0.1);
        }}

        .vulnerability.high {{ border-left-color: #e74c3c; }}
        .vulnerability.medium {{ border-left-color: #f39c12; }}
        .vulnerability.low {{ border-left-color: #27ae60; }}

        .vuln-header {{
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 15px;
        }}

        .vuln-title {{
            font-size: 1.3em;
            font-weight: bold;
            color: #2c3e50;
        }}

        .vuln-details {{
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 15px;
            margin-bottom: 15px;
        }}

        .detail-item {{
            display: flex;
            flex-direction: column;
        }}

        .detail-label {{
            font-weight: bold;
            color: #7f8c8d;
            font-size: 0.9em;
            margin-bottom: 5px;
        }}

        .detail-value {{
            color: #2c3e50;
            font-family: 'Courier New', monospace;
            background: #f8f9fa;
            padding: 8px;
            border-radius: 4px;
        }}

        .code-snippet {{
            background: #282c34;
            color: #abb2bf;
            padding: 15px;
            border-radius: 5px;
            overflow-x: auto;
            font-family: 'Courier New', monospace;
            font-size: 0.9em;
            margin-top: 15px;
        }}

        .code-snippet pre {{
            margin: 0;
            white-space: pre-wrap;
            word-wrap: break-word;
        }}

        .footer {{
            background: #2c3e50;
            color: white;
            text-align: center;
            padding: 20px;
            font-size: 0.9em;
        }}

        .no-vulnerabilities {{
            text-align: center;
            padding: 60px 20px;
            color: #27ae60;
            font-size: 1.3em;
        }}

        .no-vulnerabilities i {{
            font-size: 4em;
            display: block;
            margin-bottom: 20px;
        }}
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>T-SQL Security Scan Report</h1>
            <p class="subtitle">SQL Injection Vulnerability Detection</p>
            <p class="subtitle">Generated: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}</p>
        </div>

        <div class="summary">
            <div class="summary-card">
                <div class="number">{len(self.vulnerabilities)}</div>
                <div class="label">Total Vulnerabilities</div>
            </div>
            <div class="summary-card high">
                <div class="number">{len(high_risk)}</div>
                <div class="label">High Risk</div>
            </div>
            <div class="summary-card medium">
                <div class="number">{len(medium_risk)}</div>
                <div class="label">Medium Risk</div>
            </div>
            <div class="summary-card low">
                <div class="number">{len(low_risk)}</div>
                <div class="label">Low Risk</div>
            </div>
        </div>

        <div class="content">
"""

        if not self.vulnerabilities:
            html += """
            <div class="no-vulnerabilities">
                <div style="font-size: 4em; margin-bottom: 20px;">✓</div>
                <strong>No SQL Injection Vulnerabilities Detected</strong>
                <p style="margin-top: 10px; font-size: 0.9em; color: #7f8c8d;">
                    Your database code appears to be safe from the tested patterns.
                </p>
            </div>
"""
        else:
            # High Risk Section
            if high_risk:
                html += self._generate_risk_section("High Risk Vulnerabilities", high_risk, "high")

            # Medium Risk Section
            if medium_risk:
                html += self._generate_risk_section("Medium Risk Vulnerabilities", medium_risk, "medium")

            # Low Risk Section
            if low_risk:
                html += self._generate_risk_section("Low Risk Vulnerabilities", low_risk, "low")

        html += """
        </div>

        <div class="footer">
            <p>T-SQL Security Scanner - Defensive Security Tool</p>
            <p>This report identifies potential SQL injection vulnerabilities for remediation purposes.</p>
        </div>
    </div>
</body>
</html>
"""

        with open(output_file, 'w', encoding='utf-8') as f:
            f.write(html)

        print(f"\n✓ HTML report generated: {output_file}")
        return output_file

    def _generate_risk_section(self, title: str, vulnerabilities: List[Vulnerability], risk_class: str) -> str:
        """Generate HTML section for a specific risk level"""
        html = f"""
            <div class="section">
                <div class="section-header">
                    <h2>{title}</h2>
                    <span class="risk-badge {risk_class}">{len(vulnerabilities)} Found</span>
                </div>
"""

        for vuln in vulnerabilities:
            html += f"""
                <div class="vulnerability {risk_class}">
                    <div class="vuln-header">
                        <div class="vuln-title">{vuln.schema_name}.{vuln.object_name}</div>
                        <span class="risk-badge {risk_class}">{vuln.risk_level}</span>
                    </div>

                    <div class="vuln-details">
                        <div class="detail-item">
                            <span class="detail-label">Database</span>
                            <span class="detail-value">{vuln.database_name}</span>
                        </div>
                        <div class="detail-item">
                            <span class="detail-label">Object Type</span>
                            <span class="detail-value">{vuln.object_type}</span>
                        </div>
                        <div class="detail-item">
                            <span class="detail-label">Line Number</span>
                            <span class="detail-value">{vuln.line_number}</span>
                        </div>
                        <div class="detail-item">
                            <span class="detail-label">Variable</span>
                            <span class="detail-value">{vuln.variable_name} ({vuln.variable_type})</span>
                        </div>
                        <div class="detail-item">
                            <span class="detail-label">Execution Method</span>
                            <span class="detail-value">{vuln.execution_method}</span>
                        </div>
                    </div>

                    <div class="detail-item">
                        <span class="detail-label">Concatenation Pattern</span>
                        <span class="detail-value">{self._escape_html(vuln.concatenation_pattern)}</span>
                    </div>

                    <div class="code-snippet">
                        <pre>{self._escape_html(vuln.code_snippet)}</pre>
                    </div>
                </div>
"""

        html += "            </div>\n"
        return html

    def _escape_html(self, text: str) -> str:
        """Escape HTML special characters"""
        return (text
                .replace('&', '&amp;')
                .replace('<', '&lt;')
                .replace('>', '&gt;')
                .replace('"', '&quot;')
                .replace("'", '&#39;'))


def main():
    """Main entry point"""
    parser = argparse.ArgumentParser(
        description='T-SQL Security Scanner - SQL Injection Vulnerability Detection Tool',
        formatter_class=argparse.RawDescriptionHelpFormatter,
        epilog="""
Examples:
  # Windows Authentication
  python tsql_scanner.py -s localhost -d MyDatabase -w

  # SQL Server Authentication
  python tsql_scanner.py -s localhost\\SQLEXPRESS -d MyDatabase -u sa -p MyPassword

  # Specify custom output file
  python tsql_scanner.py -s localhost -d MyDatabase -w -o custom_report.html
        """
    )

    parser.add_argument('-s', '--server', required=True,
                        help='SQL Server instance (e.g., localhost or localhost\\SQLEXPRESS)')
    parser.add_argument('-d', '--database', required=True,
                        help='Database name to scan')
    parser.add_argument('-w', '--windows-auth', action='store_true',
                        help='Use Windows Authentication')
    parser.add_argument('-u', '--username',
                        help='SQL Server username (required if not using Windows auth)')
    parser.add_argument('-p', '--password',
                        help='SQL Server password (required if not using Windows auth)')
    parser.add_argument('-o', '--output', default='tsql_scan_report.html',
                        help='Output HTML file name (default: tsql_scan_report.html)')
    parser.add_argument('--driver', default='ODBC Driver 17 for SQL Server',
                        help='ODBC driver name (default: ODBC Driver 17 for SQL Server)')

    args = parser.parse_args()

    # Validate authentication arguments
    if not args.windows_auth and (not args.username or not args.password):
        parser.error("SQL Server authentication requires both --username and --password")

    print("=" * 60)
    print("T-SQL Security Scanner")
    print("SQL Injection Vulnerability Detection Tool")
    print("=" * 60)
    print()

    # Build connection string
    if args.windows_auth:
        connection_string = (
            f"DRIVER={{{args.driver}}};"
            f"SERVER={args.server};"
            f"DATABASE={args.database};"
            f"Trusted_Connection=yes;"
        )
        print(f"Server: {args.server}")
        print(f"Database: {args.database}")
        print(f"Authentication: Windows")
    else:
        connection_string = (
            f"DRIVER={{{args.driver}}};"
            f"SERVER={args.server};"
            f"DATABASE={args.database};"
            f"UID={args.username};"
            f"PWD={args.password};"
        )
        print(f"Server: {args.server}")
        print(f"Database: {args.database}")
        print(f"Authentication: SQL Server (User: {args.username})")

    print(f"Output file: {args.output}")

    print("\n" + "=" * 60)
    print("Starting scan...")
    print("=" * 60 + "\n")

    try:
        scanner = TSQLScanner(connection_string)
        scanner.scan_database()
        scanner.generate_html_report(args.output)

        print("\n" + "=" * 60)
        print("Scan Summary:")
        print("=" * 60)
        print(f"Total vulnerabilities found: {len(scanner.vulnerabilities)}")
        print(f"  - High Risk: {len([v for v in scanner.vulnerabilities if v.risk_level == 'HIGH'])}")
        print(f"  - Medium Risk: {len([v for v in scanner.vulnerabilities if v.risk_level == 'MEDIUM'])}")
        print(f"  - Low Risk: {len([v for v in scanner.vulnerabilities if v.risk_level == 'LOW'])}")
        print(f"\nReport saved to: {args.output}")
        print("=" * 60)

    except Exception as e:
        print(f"\n✗ Error: {str(e)}")
        return 1

    return 0


if __name__ == "__main__":
    exit(main())

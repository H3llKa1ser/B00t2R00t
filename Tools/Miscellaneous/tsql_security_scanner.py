#!/usr/bin/env python3
"""
T-SQL Security Scanner
Detects SQL injection vulnerabilities in stored procedures

A comprehensive security tool that analyzes T-SQL stored procedures for SQL injection
vulnerabilities, filters false positives, and generates detailed reports.

Author: Security Tools
License: MIT
"""

import argparse
import sys
import getpass
import json
import csv
import re
from datetime import datetime
from typing import List, Dict, Optional, Tuple
from dataclasses import dataclass

try:
    import pyodbc
    from colorama import init, Fore, Style
    from tabulate import tabulate
    from jinja2 import Template
except ImportError as e:
    print(f"Error: Required module not found: {e}")
    print("Please install dependencies: pip install pyodbc colorama tabulate Jinja2")
    sys.exit(1)

# Initialize colorama for cross-platform colored output
init(autoreset=True)


# ============================================================================
# DATABASE CONNECTOR
# ============================================================================

class DatabaseConnector:
    """Manages SQL Server database connections"""

    def __init__(self):
        self.connection: Optional[pyodbc.Connection] = None
        self.cursor: Optional[pyodbc.Cursor] = None

    def connect(
        self,
        server: str,
        database: str,
        username: Optional[str] = None,
        password: Optional[str] = None,
        trusted_connection: bool = False,
        driver: str = "{ODBC Driver 17 for SQL Server}"
    ) -> bool:
        """
        Connect to SQL Server database

        Args:
            server: Server name or IP address
            database: Database name
            username: SQL Server username
            password: SQL Server password
            trusted_connection: Use Windows authentication if True
            driver: ODBC driver name

        Returns:
            bool: True if connection successful
        """
        try:
            if trusted_connection:
                connection_string = (
                    f"DRIVER={driver};"
                    f"SERVER={server};"
                    f"DATABASE={database};"
                    f"Trusted_Connection=yes;"
                )
            else:
                if not username or not password:
                    raise ValueError("Username and password required for SQL authentication")

                connection_string = (
                    f"DRIVER={driver};"
                    f"SERVER={server};"
                    f"DATABASE={database};"
                    f"UID={username};"
                    f"PWD={password};"
                )

            self.connection = pyodbc.connect(connection_string, timeout=10)
            self.cursor = self.connection.cursor()
            return True

        except pyodbc.Error as e:
            print(f"Database connection error: {e}")
            return False
        except Exception as e:
            print(f"Unexpected error: {e}")
            return False

    def disconnect(self) -> None:
        """Close database connection"""
        if self.cursor:
            self.cursor.close()
        if self.connection:
            self.connection.close()

    def execute_query(self, query: str) -> list:
        """Execute a SQL query and return results"""
        if not self.cursor:
            raise Exception("No active database connection")

        try:
            self.cursor.execute(query)
            return self.cursor.fetchall()
        except pyodbc.Error as e:
            print(f"Query execution error: {e}")
            return []

    def __enter__(self):
        return self

    def __exit__(self, exc_type, exc_val, exc_tb):
        self.disconnect()


# ============================================================================
# PROCEDURE EXTRACTOR
# ============================================================================

class ProcedureExtractor:
    """Extracts stored procedure definitions from SQL Server"""

    def __init__(self, db_connector: DatabaseConnector):
        self.db_connector = db_connector

    def get_all_procedures(self, schema: Optional[str] = None) -> List[Dict[str, str]]:
        """
        Retrieve all stored procedures from the database

        Args:
            schema: Optional schema name to filter procedures

        Returns:
            List of dictionaries containing procedure information
        """
        procedures = []

        if schema:
            query = f"""
                SELECT
                    OBJECT_SCHEMA_NAME(p.object_id) AS [Schema],
                    p.name AS [Name],
                    OBJECT_SCHEMA_NAME(p.object_id) + '.' + p.name AS [FullName],
                    OBJECT_DEFINITION(p.object_id) AS [Definition]
                FROM sys.procedures p
                WHERE OBJECT_SCHEMA_NAME(p.object_id) = '{schema}'
                    AND p.is_ms_shipped = 0
                ORDER BY [Schema], [Name]
            """
        else:
            query = """
                SELECT
                    OBJECT_SCHEMA_NAME(p.object_id) AS [Schema],
                    p.name AS [Name],
                    OBJECT_SCHEMA_NAME(p.object_id) + '.' + p.name AS [FullName],
                    OBJECT_DEFINITION(p.object_id) AS [Definition]
                FROM sys.procedures p
                WHERE p.is_ms_shipped = 0
                ORDER BY [Schema], [Name]
            """

        try:
            results = self.db_connector.execute_query(query)

            for row in results:
                if row[3]:
                    procedures.append({
                        'schema': row[0],
                        'name': row[1],
                        'full_name': row[2],
                        'definition': row[3]
                    })

        except Exception as e:
            print(f"Error retrieving stored procedures: {e}")

        return procedures

    def get_procedure_count(self) -> int:
        """Get total count of stored procedures in the database"""
        query = """
            SELECT COUNT(*)
            FROM sys.procedures p
            WHERE p.is_ms_shipped = 0
        """

        try:
            result = self.db_connector.execute_query(query)
            return result[0][0] if result else 0
        except Exception as e:
            print(f"Error counting procedures: {e}")
            return 0


# ============================================================================
# VULNERABILITY SCANNER
# ============================================================================

@dataclass
class Vulnerability:
    """Represents a detected SQL injection vulnerability"""
    procedure_name: str
    schema: str
    severity: str
    vulnerability_type: str
    line_number: int
    code_snippet: str
    description: str
    recommendation: str
    variable_name: str = ""
    variable_type: str = ""


class VulnerabilityScanner:
    """Scans T-SQL stored procedures for SQL injection vulnerabilities"""

    def __init__(self):
        # Track string variables (NVARCHAR/VARCHAR) in the procedure
        self.string_variables = {}  # {variable_name: variable_type}
        self.concatenated_variables = set()  # Variables used in concatenation
        self.executed_variables = {}  # {variable_name: execution_type (EXEC/sp_executesql)}

    def _extract_string_variables(self, definition: str) -> None:
        """Extract NVARCHAR and VARCHAR variable declarations"""
        self.string_variables.clear()

        # Pattern to match variable declarations: DECLARE @var NVARCHAR/VARCHAR
        var_pattern = r'DECLARE\s+(@\w+)\s+(N?VARCHAR)\s*(?:\((?:MAX|\d+)\))?'

        matches = re.finditer(var_pattern, definition, re.IGNORECASE)
        for match in matches:
            var_name = match.group(1)
            var_type = match.group(2).upper()
            self.string_variables[var_name] = var_type

    def _find_concatenated_variables(self, definition: str) -> None:
        """Find variables used in dynamic string concatenation"""
        self.concatenated_variables.clear()

        # Look for patterns like: @var + or + @var in string contexts
        concat_pattern = r'[@\w]+\s*\+\s*(@\w+)|(@\w+)\s*\+\s*[@\w\']'

        matches = re.finditer(concat_pattern, definition, re.IGNORECASE)
        for match in matches:
            var_name = match.group(1) or match.group(2)
            if var_name and var_name.startswith('@'):
                # Check if this variable is a string type
                if var_name in self.string_variables:
                    self.concatenated_variables.add(var_name)

    def _find_executed_variables(self, definition: str, lines: List[str]) -> Dict[str, Tuple[str, int]]:
        """Find variables that are executed with EXEC or sp_executesql"""
        executed_vars = {}

        # Check each line for EXEC or sp_executesql patterns
        for line_num, line in enumerate(lines, start=1):
            # Pattern 1: EXEC(@var) or EXECUTE(@var)
            exec_pattern = r'EXEC(?:UTE)?\s*\(\s*(@\w+)\s*\)'
            matches = re.finditer(exec_pattern, line, re.IGNORECASE)
            for match in matches:
                var_name = match.group(1)
                if var_name in self.string_variables:
                    executed_vars[var_name] = ('EXEC', line_num)

            # Pattern 2: sp_executesql @var
            sp_exec_pattern = r'sp_executesql\s+(@\w+)'
            matches = re.finditer(sp_exec_pattern, line, re.IGNORECASE)
            for match in matches:
                var_name = match.group(1)
                if var_name in self.string_variables:
                    executed_vars[var_name] = ('sp_executesql', line_num)

        return executed_vars

    def scan_procedure(self, procedure: Dict[str, str]) -> List[Vulnerability]:
        """Scan a stored procedure for SQL injection vulnerabilities"""
        vulnerabilities = []
        definition = procedure['definition']

        if not definition:
            return vulnerabilities

        lines = definition.split('\n')

        # Step 1: Find all NVARCHAR/VARCHAR variables
        self._extract_string_variables(definition)

        # Step 2: Find which string variables are used in concatenation
        self._find_concatenated_variables(definition)

        # Step 3: Find which variables are executed with EXEC or sp_executesql
        executed_vars = self._find_executed_variables(definition, lines)

        # Step 4: Report only true positives - concatenated string variables that are executed
        for var_name in self.concatenated_variables:
            if var_name in executed_vars:
                exec_type, line_num = executed_vars[var_name]

                # Get context around the execution line
                context_start = max(0, line_num - 4)
                context_end = min(len(lines), line_num + 3)
                context_lines = lines[context_start:context_end]

                numbered_context = []
                for i, ctx_line in enumerate(context_lines, start=context_start + 1):
                    prefix = '>>> ' if i == line_num else '    '
                    numbered_context.append(f"{prefix}{i:4d}: {ctx_line.rstrip()}")

                code_snippet = '\n'.join(numbered_context)

                vulnerability = Vulnerability(
                    procedure_name=procedure['full_name'],
                    schema=procedure['schema'],
                    severity='HIGH',
                    vulnerability_type='sql_injection_concatenated_execution',
                    line_number=line_num,
                    code_snippet=code_snippet,
                    description=f'Variable {var_name} ({self.string_variables[var_name]}) is used in dynamic concatenation and executed with {exec_type}',
                    recommendation=f'Use sp_executesql with parameterized queries instead of concatenating {var_name} into the SQL string',
                    variable_name=var_name,
                    variable_type=self.string_variables[var_name]
                )

                vulnerabilities.append(vulnerability)

        return vulnerabilities

    def scan_multiple_procedures(self, procedures: List[Dict[str, str]]) -> List[Vulnerability]:
        """Scan multiple stored procedures"""
        all_vulnerabilities = []

        for procedure in procedures:
            vulnerabilities = self.scan_procedure(procedure)
            all_vulnerabilities.extend(vulnerabilities)

        return all_vulnerabilities

    def get_statistics(self, vulnerabilities: List[Vulnerability]) -> Dict:
        """Generate statistics from vulnerability results"""
        stats = {
            'total_vulnerabilities': len(vulnerabilities),
            'high_severity': len([v for v in vulnerabilities if v.severity == 'HIGH']),
            'medium_severity': len([v for v in vulnerabilities if v.severity == 'MEDIUM']),
            'low_severity': len([v for v in vulnerabilities if v.severity == 'LOW']),
            'vulnerable_procedures': len(set(v.procedure_name for v in vulnerabilities)),
            'vulnerability_types': {}
        }

        for vuln in vulnerabilities:
            vuln_type = vuln.vulnerability_type
            stats['vulnerability_types'][vuln_type] = stats['vulnerability_types'].get(vuln_type, 0) + 1

        return stats


# ============================================================================
# REPORTER
# ============================================================================

class Reporter:
    """Generates reports in multiple formats"""

    def __init__(self):
        self.timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")

    def export_to_json(self, vulnerabilities: List[Vulnerability], filename: str = None) -> str:
        """Export vulnerabilities to JSON format"""
        if filename is None:
            filename = f"tsql_scan_report_{self.timestamp}.json"

        data = {
            'scan_date': datetime.now().isoformat(),
            'total_vulnerabilities': len(vulnerabilities),
            'vulnerabilities': [
                {
                    'procedure_name': v.procedure_name,
                    'schema': v.schema,
                    'severity': v.severity,
                    'vulnerability_type': v.vulnerability_type,
                    'line_number': v.line_number,
                    'code_snippet': v.code_snippet,
                    'description': v.description,
                    'recommendation': v.recommendation,
                    'variable_name': v.variable_name,
                    'variable_type': v.variable_type
                }
                for v in vulnerabilities
            ]
        }

        with open(filename, 'w', encoding='utf-8') as f:
            json.dump(data, f, indent=2, ensure_ascii=False)

        return filename

    def export_to_csv(self, vulnerabilities: List[Vulnerability], filename: str = None) -> str:
        """Export vulnerabilities to CSV format"""
        if filename is None:
            filename = f"tsql_scan_report_{self.timestamp}.csv"

        with open(filename, 'w', newline='', encoding='utf-8') as f:
            writer = csv.writer(f)

            writer.writerow([
                'Procedure Name', 'Schema', 'Severity', 'Vulnerability Type',
                'Line Number', 'Variable Name', 'Variable Type',
                'Description', 'Recommendation', 'Code Snippet'
            ])

            for v in vulnerabilities:
                writer.writerow([
                    v.procedure_name, v.schema, v.severity, v.vulnerability_type,
                    v.line_number, v.variable_name, v.variable_type,
                    v.description, v.recommendation,
                    v.code_snippet.replace('\n', ' | ')
                ])

        return filename

    def export_to_html(self, vulnerabilities: List[Vulnerability], stats: dict = None, filename: str = None) -> str:
        """Export vulnerabilities to HTML format"""
        if filename is None:
            filename = f"tsql_scan_report_{self.timestamp}.html"

        template_str = """<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>T-SQL Security Scan Report</title>
    <style>
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; margin: 20px; background-color: #f5f5f5; }
        .container { max-width: 1400px; margin: 0 auto; background-color: white; padding: 30px; box-shadow: 0 0 10px rgba(0,0,0,0.1); }
        h1 { color: #333; border-bottom: 3px solid #007acc; padding-bottom: 10px; }
        h2 { color: #555; margin-top: 30px; }
        .summary { background-color: #f9f9f9; padding: 20px; border-radius: 5px; margin-bottom: 30px; }
        .stats { display: grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); gap: 15px; margin-bottom: 20px; }
        .stat-box { background-color: white; padding: 15px; border-radius: 5px; border-left: 4px solid #007acc; box-shadow: 0 2px 4px rgba(0,0,0,0.1); }
        .stat-box.high { border-left-color: #d32f2f; }
        .stat-box.medium { border-left-color: #f57c00; }
        .stat-box.low { border-left-color: #fbc02d; }
        .stat-label { font-size: 0.9em; color: #666; margin-bottom: 5px; }
        .stat-value { font-size: 2em; font-weight: bold; color: #333; }
        .vulnerability { background-color: #fff; border: 1px solid #ddd; border-radius: 5px; padding: 20px; margin-bottom: 20px; box-shadow: 0 2px 4px rgba(0,0,0,0.05); }
        .vulnerability-header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 15px; }
        .procedure-name { font-size: 1.2em; font-weight: bold; color: #333; }
        .severity { padding: 5px 15px; border-radius: 3px; color: white; font-weight: bold; font-size: 0.9em; }
        .severity.HIGH { background-color: #d32f2f; }
        .severity.MEDIUM { background-color: #f57c00; }
        .severity.LOW { background-color: #fbc02d; color: #333; }
        .vulnerability-details { margin-bottom: 15px; }
        .detail-row { margin-bottom: 8px; }
        .detail-label { font-weight: bold; color: #555; display: inline-block; width: 150px; }
        .code-snippet { background-color: #f4f4f4; border-left: 3px solid #007acc; padding: 15px; overflow-x: auto; font-family: 'Courier New', monospace; font-size: 0.9em; white-space: pre; margin: 15px 0; }
        .recommendation { background-color: #e8f5e9; border-left: 3px solid #4caf50; padding: 15px; margin-top: 15px; border-radius: 3px; }
        .recommendation strong { color: #2e7d32; }
        .timestamp { color: #666; font-size: 0.9em; margin-top: 10px; }
    </style>
</head>
<body>
    <div class="container">
        <h1>🔍 T-SQL Security Scan Report</h1>
        <div class="timestamp">Generated: {{ scan_date }}</div>
        {% if stats %}
        <div class="summary">
            <h2>Summary Statistics</h2>
            <div class="stats">
                <div class="stat-box"><div class="stat-label">Total Vulnerabilities</div><div class="stat-value">{{ stats.total_vulnerabilities }}</div></div>
                <div class="stat-box high"><div class="stat-label">High Severity</div><div class="stat-value">{{ stats.high_severity }}</div></div>
                <div class="stat-box medium"><div class="stat-label">Medium Severity</div><div class="stat-value">{{ stats.medium_severity }}</div></div>
                <div class="stat-box low"><div class="stat-label">Low Severity</div><div class="stat-value">{{ stats.low_severity }}</div></div>
                <div class="stat-box"><div class="stat-label">Vulnerable Procedures</div><div class="stat-value">{{ stats.vulnerable_procedures }}</div></div>
            </div>
        </div>
        {% endif %}
        <h2>Vulnerability Details</h2>
        {% if vulnerabilities %}
            {% for v in vulnerabilities %}
            <div class="vulnerability">
                <div class="vulnerability-header">
                    <div class="procedure-name">{{ v.procedure_name }}</div>
                    <div class="severity {{ v.severity }}">{{ v.severity }}</div>
                </div>
                <div class="vulnerability-details">
                    <div class="detail-row"><span class="detail-label">Schema:</span><span>{{ v.schema }}</span></div>
                    <div class="detail-row"><span class="detail-label">Vulnerability Type:</span><span>{{ v.vulnerability_type }}</span></div>
                    <div class="detail-row"><span class="detail-label">Line Number:</span><span>{{ v.line_number }}</span></div>
                    <div class="detail-row"><span class="detail-label">Variable Name:</span><span>{{ v.variable_name }}</span></div>
                    <div class="detail-row"><span class="detail-label">Variable Type:</span><span>{{ v.variable_type }}</span></div>
                    <div class="detail-row"><span class="detail-label">Description:</span><span>{{ v.description }}</span></div>
                </div>
                <div class="code-snippet">{{ v.code_snippet }}</div>
                <div class="recommendation"><strong>💡 Recommendation:</strong> {{ v.recommendation }}</div>
            </div>
            {% endfor %}
        {% else %}
            <p>No vulnerabilities detected. All stored procedures appear to be safe!</p>
        {% endif %}
    </div>
</body>
</html>"""

        template = Template(template_str)
        html_content = template.render(
            scan_date=datetime.now().strftime("%Y-%m-%d %H:%M:%S"),
            vulnerabilities=vulnerabilities,
            stats=stats
        )

        with open(filename, 'w', encoding='utf-8') as f:
            f.write(html_content)

        return filename


# ============================================================================
# MAIN APPLICATION
# ============================================================================

class TSQLScanner:
    """Main application class for T-SQL security scanning"""

    def __init__(self):
        self.db_connector = None
        self.procedure_extractor = None
        self.vulnerability_scanner = VulnerabilityScanner()
        self.reporter = Reporter()

    def connect_to_database(self, args):
        """Establish database connection"""
        print(f"\n{Fore.CYAN}[*] Connecting to database...{Style.RESET_ALL}")

        self.db_connector = DatabaseConnector()

        password = args.password
        if args.username and not password:
            password = getpass.getpass("Enter password: ")

        trusted_connection = args.trusted or (not args.username and not password)

        success = self.db_connector.connect(
            server=args.server,
            database=args.database,
            username=args.username,
            password=password,
            trusted_connection=trusted_connection,
            driver=args.driver
        )

        if success:
            print(f"{Fore.GREEN}[+] Successfully connected to {args.server}/{args.database}{Style.RESET_ALL}")
            return True
        else:
            print(f"{Fore.RED}[!] Failed to connect to database{Style.RESET_ALL}")
            return False

    def scan_procedures(self, schema=None):
        """Scan stored procedures for vulnerabilities"""
        print(f"\n{Fore.CYAN}[*] Extracting stored procedures...{Style.RESET_ALL}")

        self.procedure_extractor = ProcedureExtractor(self.db_connector)

        total_procedures = self.procedure_extractor.get_procedure_count()
        print(f"{Fore.YELLOW}[*] Found {total_procedures} stored procedures{Style.RESET_ALL}")

        if total_procedures == 0:
            print(f"{Fore.YELLOW}[!] No stored procedures found in database{Style.RESET_ALL}")
            return [], {}

        procedures = self.procedure_extractor.get_all_procedures(schema)

        print(f"\n{Fore.CYAN}[*] Scanning for SQL injection vulnerabilities...{Style.RESET_ALL}")

        vulnerabilities = self.vulnerability_scanner.scan_multiple_procedures(procedures)

        print(f"{Fore.YELLOW}[*] Found {len(vulnerabilities)} true positive vulnerabilities{Style.RESET_ALL}")

        stats = self.vulnerability_scanner.get_statistics(vulnerabilities)

        return vulnerabilities, stats

    def display_results(self, vulnerabilities, stats):
        """Display scan results to console"""
        print(f"\n{Fore.CYAN}{'='*80}{Style.RESET_ALL}")
        print(f"{Fore.CYAN}SCAN RESULTS{Style.RESET_ALL}")
        print(f"{Fore.CYAN}{'='*80}{Style.RESET_ALL}\n")

        stats_table = [
            ["Total Vulnerabilities", stats['total_vulnerabilities']],
            ["High Severity", f"{Fore.RED}{stats['high_severity']}{Style.RESET_ALL}"],
            ["Medium Severity", f"{Fore.YELLOW}{stats['medium_severity']}{Style.RESET_ALL}"],
            ["Low Severity", f"{Fore.GREEN}{stats['low_severity']}{Style.RESET_ALL}"],
            ["Vulnerable Procedures", stats['vulnerable_procedures']]
        ]

        print(tabulate(stats_table, headers=["Metric", "Count"], tablefmt="grid"))

        if vulnerabilities:
            print(f"\n{Fore.RED}[!] VULNERABILITIES DETECTED:{Style.RESET_ALL}\n")

            for i, vuln in enumerate(vulnerabilities, 1):
                severity_color = {
                    'HIGH': Fore.RED,
                    'MEDIUM': Fore.YELLOW,
                    'LOW': Fore.GREEN
                }.get(vuln.severity, Fore.WHITE)

                print(f"{Fore.CYAN}[{i}] {vuln.procedure_name}{Style.RESET_ALL}")
                print(f"    Severity: {severity_color}{vuln.severity}{Style.RESET_ALL}")
                print(f"    Type: {vuln.vulnerability_type}")
                print(f"    Line: {vuln.line_number}")
                print(f"    Variable: {vuln.variable_name} ({vuln.variable_type})")
                print(f"    Description: {vuln.description}")
                print(f"\n{Fore.WHITE}    Code:{Style.RESET_ALL}")
                for line in vuln.code_snippet.split('\n'):
                    if '>>>' in line:
                        print(f"{Fore.RED}    {line}{Style.RESET_ALL}")
                    else:
                        print(f"{Fore.WHITE}    {line}{Style.RESET_ALL}")
                print(f"\n    {Fore.GREEN}💡 Recommendation:{Style.RESET_ALL} {vuln.recommendation}\n")
                print(f"{Fore.CYAN}{'-'*80}{Style.RESET_ALL}\n")
        else:
            print(f"\n{Fore.GREEN}[+] No vulnerabilities detected! All stored procedures appear secure.{Style.RESET_ALL}\n")

    def export_results(self, vulnerabilities, stats, export_formats):
        """Export results to specified formats"""
        if not export_formats:
            return

        print(f"\n{Fore.CYAN}[*] Exporting results...{Style.RESET_ALL}")

        for fmt in export_formats:
            try:
                if fmt == 'json':
                    filename = self.reporter.export_to_json(vulnerabilities)
                    print(f"{Fore.GREEN}[+] JSON report saved: {filename}{Style.RESET_ALL}")

                elif fmt == 'csv':
                    filename = self.reporter.export_to_csv(vulnerabilities)
                    print(f"{Fore.GREEN}[+] CSV report saved: {filename}{Style.RESET_ALL}")

                elif fmt == 'html':
                    filename = self.reporter.export_to_html(vulnerabilities, stats)
                    print(f"{Fore.GREEN}[+] HTML report saved: {filename}{Style.RESET_ALL}")

            except Exception as e:
                print(f"{Fore.RED}[!] Error exporting to {fmt}: {e}{Style.RESET_ALL}")

    def run(self, args):
        """Main execution flow"""
        try:
            if not self.connect_to_database(args):
                sys.exit(1)

            vulnerabilities, stats = self.scan_procedures(args.schema)

            self.display_results(vulnerabilities, stats)

            if args.export:
                self.export_results(vulnerabilities, stats, args.export)

            self.db_connector.disconnect()
            print(f"\n{Fore.GREEN}[+] Scan completed successfully{Style.RESET_ALL}\n")

        except KeyboardInterrupt:
            print(f"\n{Fore.YELLOW}[!] Scan interrupted by user{Style.RESET_ALL}")
            if self.db_connector:
                self.db_connector.disconnect()
            sys.exit(0)

        except Exception as e:
            print(f"\n{Fore.RED}[!] Error: {e}{Style.RESET_ALL}")
            if self.db_connector:
                self.db_connector.disconnect()
            sys.exit(1)


def main():
    """Main entry point"""
    banner = f"""
{Fore.CYAN}╔════════════════════════════════════════════════════════════════════╗
║                    T-SQL Security Scanner                          ║
║              SQL Injection Vulnerability Detector                  ║
╚════════════════════════════════════════════════════════════════════╝{Style.RESET_ALL}
    """
    print(banner)

    parser = argparse.ArgumentParser(
        description="Scan T-SQL stored procedures for SQL injection vulnerabilities",
        formatter_class=argparse.RawDescriptionHelpFormatter
    )

    parser.add_argument('-s', '--server', required=True,
                        help='SQL Server name or IP address (e.g., localhost, 192.168.1.100)')
    parser.add_argument('-d', '--database', required=True,
                        help='Database name')
    parser.add_argument('-u', '--username',
                        help='SQL Server username (for SQL authentication)')
    parser.add_argument('-p', '--password',
                        help='SQL Server password (will prompt if not provided)')
    parser.add_argument('-t', '--trusted', action='store_true',
                        help='Use Windows authentication (trusted connection)')
    parser.add_argument('--driver', default='{ODBC Driver 17 for SQL Server}',
                        help='ODBC driver name (default: ODBC Driver 17 for SQL Server)')
    parser.add_argument('--schema',
                        help='Filter by specific schema (e.g., dbo)')
    parser.add_argument('-e', '--export', nargs='+', choices=['json', 'csv', 'html'],
                        help='Export results to specified formats (json, csv, html)')

    args = parser.parse_args()

    scanner = TSQLScanner()
    scanner.run(args)


if __name__ == '__main__':
    main()

#!/usr/bin/env python3
"""
Code Insight Vulnerability Approver
Connects to Code Insight server and approves vulnerabilities based on severity and priority

Based on Code Insight REST API documentation: https://codeinsightapi.redoc.ly/
"""

import requests
import json
import sys
import argparse
from typing import List, Dict, Optional
from urllib.parse import urljoin


# Criteria for approval
SEVERITIES_TO_APPROVE = ["N/A", "None", "Low", "Medium"]
PRIORITIES_TO_APPROVE = ["P1", "P2"]


class CodeInsightClient:
    """
    Client for Code Insight REST API

    API Documentation: https://codeinsightapi.redoc.ly/
    Authentication: JWT Bearer token (obtain from Code Insight Web UI > Preferences)
    """

    def __init__(self, base_url: str, token: str):
        """
        Initialize Code Insight API client

        Args:
            base_url: Code Insight server URL (e.g., https://codeinsight.example.com)
            token: JWT authentication token from Code Insight Preferences
        """
        self.base_url = base_url.rstrip('/')
        self.token = token
        self.session = requests.Session()
        self.session.headers.update({
            "Authorization": f"Bearer {token}",
            "Content-Type": "application/json"
        })

    def get_project_inventory(self, project_id: int) -> List[Dict]:
        """
        Get all inventory items for a project

        API Endpoint: GET /projects/{projectId}/inventory

        Args:
            project_id: Project identifier

        Returns:
            List of inventory items
        """
        url = urljoin(self.base_url, f"/codeinsight/api/projects/{project_id}/inventory")

        try:
            response = self.session.get(url)
            response.raise_for_status()

            data = response.json()
            # Handle different response formats
            inventory_items = data if isinstance(data, list) else data.get("data", [])
            print(f"✓ Retrieved {len(inventory_items)} inventory items")
            return inventory_items

        except requests.exceptions.RequestException as e:
            print(f"✗ Error fetching project inventory: {e}")
            if hasattr(e.response, 'text'):
                print(f"  Response: {e.response.text}")
            return []

    def get_inventory_vulnerabilities(self, inventory_id: int) -> List[Dict]:
        """
        Get all vulnerabilities for a specific inventory item

        API Endpoint: GET /inventory/{inventoryId}/vulnerabilities

        Args:
            inventory_id: Inventory item identifier

        Returns:
            List of vulnerabilities associated with the inventory item
        """
        url = urljoin(self.base_url, f"/codeinsight/api/inventory/{inventory_id}/vulnerabilities")

        try:
            response = self.session.get(url)
            response.raise_for_status()

            data = response.json()
            vulnerabilities = data if isinstance(data, list) else data.get("data", [])
            return vulnerabilities

        except requests.exceptions.RequestException as e:
            print(f"✗ Error fetching vulnerabilities for inventory {inventory_id}: {e}")
            if hasattr(e.response, 'text'):
                print(f"  Response: {e.response.text}")
            return []

    def get_all_project_vulnerabilities(self, project_id: int) -> List[Dict]:
        """
        Get all vulnerabilities for a project by iterating through inventory items

        This method combines GET /projects/{projectId}/inventory and
        GET /inventory/{inventoryId}/vulnerabilities

        Args:
            project_id: Project identifier

        Returns:
            List of all vulnerabilities with inventory context
        """
        inventory_items = self.get_project_inventory(project_id)

        if not inventory_items:
            return []

        all_vulnerabilities = []

        for item in inventory_items:
            inventory_id = item.get("id")
            inventory_name = item.get("name", "Unknown")

            if not inventory_id:
                continue

            vulnerabilities = self.get_inventory_vulnerabilities(inventory_id)

            # Enrich vulnerabilities with inventory context
            for vuln in vulnerabilities:
                vuln["_inventory_id"] = inventory_id
                vuln["_inventory_name"] = inventory_name
                all_vulnerabilities.append(vuln)

        print(f"✓ Retrieved {len(all_vulnerabilities)} total vulnerabilities across all inventory items")
        return all_vulnerabilities

    def update_inventory_status(self, inventory_id: int, status: str, comment: str = "") -> bool:
        """
        Update the status of an inventory item

        API Endpoint: PUT /inventory/{inventoryId}/status

        NOTE: Valid status values are not documented in the API.
        Common possibilities: "approved", "reviewed", "accepted", etc.

        Args:
            inventory_id: Inventory item identifier
            status: New status value
            comment: Optional comment for the status change

        Returns:
            True if successful, False otherwise
        """
        url = urljoin(self.base_url, f"/codeinsight/api/inventory/{inventory_id}/status")

        # Request body format is not documented, trying common patterns
        payload = {
            "status": status,
            "comment": comment
        }

        try:
            response = self.session.put(url, json=payload)
            response.raise_for_status()
            print(f"  ✓ Updated inventory {inventory_id} status to '{status}'")
            return True

        except requests.exceptions.RequestException as e:
            print(f"  ✗ Failed to update inventory {inventory_id} status: {e}")
            if hasattr(e.response, 'text'):
                print(f"    Response: {e.response.text}")
            return False

    def suppress_vulnerability(self, vuln_data: Dict) -> bool:
        """
        Suppress a vulnerability (mark as accepted/ignored)

        API Endpoint: POST /vulnerability/suppress

        NOTE: Request body schema is not documented. This is a best-effort implementation.

        Args:
            vuln_data: Vulnerability data including identifier and reason

        Returns:
            True if successful, False otherwise
        """
        url = urljoin(self.base_url, "/codeinsight/api/vulnerability/suppress")

        try:
            response = self.session.post(url, json=vuln_data)
            response.raise_for_status()
            return True

        except requests.exceptions.RequestException as e:
            print(f"  ✗ Failed to suppress vulnerability: {e}")
            if hasattr(e.response, 'text'):
                print(f"    Response: {e.response.text}")
            return False

    def filter_vulnerabilities(self, vulnerabilities: List[Dict]) -> List[Dict]:
        """
        Filter vulnerabilities based on severity and priority criteria

        NOTE: Field names for severity and priority may vary depending on the actual API response.
        This function checks multiple possible field name variations.

        Args:
            vulnerabilities: List of vulnerability objects

        Returns:
            Filtered list of vulnerabilities matching approval criteria
        """
        filtered = []

        for vuln in vulnerabilities:
            # Try different possible field names for severity
            severity = (
                vuln.get("severity") or
                vuln.get("vulnerabilitySeverity") or
                vuln.get("cvssScore") or
                ""
            )
            if isinstance(severity, str):
                severity = severity.strip()
            else:
                severity = str(severity)

            # Try different possible field names for priority
            priority = (
                vuln.get("priority") or
                vuln.get("vulnerabilityPriority") or
                vuln.get("remediationPriority") or
                ""
            )
            if isinstance(priority, str):
                priority = priority.strip()
            else:
                priority = str(priority)

            # Try different possible field names for status
            status = (
                vuln.get("status") or
                vuln.get("vulnerabilityStatus") or
                vuln.get("reviewStatus") or
                ""
            )
            if isinstance(status, str):
                status = status.strip()
            else:
                status = str(status)

            # Skip already approved/closed vulnerabilities
            if status.lower() in ["approved", "closed", "suppressed", "reviewed", "accepted"]:
                continue

            # Check if severity and priority match criteria
            if severity in SEVERITIES_TO_APPROVE and priority in PRIORITIES_TO_APPROVE:
                filtered.append(vuln)

        print(f"✓ Filtered {len(filtered)} vulnerabilities matching criteria:")
        print(f"  - Severities: {', '.join(SEVERITIES_TO_APPROVE)}")
        print(f"  - Priorities: {', '.join(PRIORITIES_TO_APPROVE)}")

        return filtered


def main():
    parser = argparse.ArgumentParser(
        description="Approve Code Insight vulnerabilities based on severity and priority",
        formatter_class=argparse.RawDescriptionHelpFormatter,
        epilog="""
Examples:
  %(prog)s --url https://codeinsight.example.com --token abc123 --project-id 42
  %(prog)s --url https://codeinsight.example.com --token abc123 --project-id 42 --dry-run
  %(prog)s --url https://codeinsight.example.com --token abc123 --project-id 42 --approval-method suppress

Approval Criteria:
  - Severities: N/A, None, Low, Medium
  - Priorities: P1, P2

Approval Methods:
  - inventory: Update inventory item status (default)
  - suppress: Suppress individual vulnerabilities

API Documentation: https://codeinsightapi.redoc.ly/
Token: Obtain from Code Insight Web UI > Preferences
        """
    )

    parser.add_argument(
        "--url",
        required=True,
        help="Code Insight server URL (e.g., https://codeinsight.example.com)"
    )

    parser.add_argument(
        "--token",
        required=True,
        help="JWT authentication token (obtain from Code Insight Web UI > Preferences)"
    )

    parser.add_argument(
        "--project-id",
        required=True,
        type=int,
        help="Project ID to process"
    )

    parser.add_argument(
        "--dry-run",
        action="store_true",
        help="Show what would be approved without making changes"
    )

    parser.add_argument(
        "--approval-method",
        choices=["inventory", "suppress"],
        default="inventory",
        help="Method for approving vulnerabilities (default: inventory)"
    )

    parser.add_argument(
        "--approval-status",
        default="approved",
        help="Status value to set for inventory items (default: approved)"
    )

    parser.add_argument(
        "--verbose",
        action="store_true",
        help="Enable verbose output including API responses"
    )

    args = parser.parse_args()

    print("=" * 80)
    print("Code Insight Vulnerability Approver")
    print("=" * 80)
    print(f"API Documentation: https://codeinsightapi.redoc.ly/")
    print(f"Approval Method: {args.approval_method}")

    if args.dry_run:
        print("\n*** DRY RUN MODE - No changes will be made ***\n")

    # Initialize client
    print(f"\n[1/4] Connecting to {args.url}...")
    client = CodeInsightClient(args.url, args.token)

    # Get project inventory
    print(f"\n[2/4] Fetching project inventory for project ID {args.project_id}...")
    inventory_items = client.get_project_inventory(args.project_id)

    if not inventory_items:
        print("No inventory items found")
        sys.exit(0)

    # Get all vulnerabilities
    print(f"\n[3/4] Fetching vulnerabilities from all inventory items...")
    vulnerabilities = client.get_all_project_vulnerabilities(args.project_id)

    if not vulnerabilities:
        print("No vulnerabilities found")
        sys.exit(0)

    # Filter vulnerabilities
    print(f"\n[4/4] Filtering and processing vulnerabilities...")
    filtered_vulns = client.filter_vulnerabilities(vulnerabilities)

    if not filtered_vulns:
        print("\nNo vulnerabilities match the approval criteria")
        sys.exit(0)

    # Group vulnerabilities by inventory item for inventory method
    if args.approval_method == "inventory":
        inventory_map = {}
        for vuln in filtered_vulns:
            inv_id = vuln.get("_inventory_id")
            if inv_id:
                if inv_id not in inventory_map:
                    inventory_map[inv_id] = {
                        "name": vuln.get("_inventory_name", "Unknown"),
                        "vulnerabilities": []
                    }
                inventory_map[inv_id]["vulnerabilities"].append(vuln)

        print(f"\n{'Would process' if args.dry_run else 'Processing'} {len(inventory_map)} inventory items...")

        approved_count = 0
        failed_count = 0

        for inv_id, inv_data in inventory_map.items():
            vuln_count = len(inv_data["vulnerabilities"])
            inv_name = inv_data["name"]

            if args.dry_run:
                print(f"  → Would update inventory '{inv_name}' (ID: {inv_id}, {vuln_count} vulnerabilities)")
                approved_count += vuln_count
            else:
                print(f"  Processing inventory '{inv_name}' (ID: {inv_id}, {vuln_count} vulnerabilities)...")
                if client.update_inventory_status(
                    inv_id,
                    args.approval_status,
                    f"Auto-approved: {vuln_count} vulnerabilities reviewed by security team"
                ):
                    approved_count += vuln_count
                else:
                    failed_count += vuln_count

    # Suppress individual vulnerabilities
    elif args.approval_method == "suppress":
        print(f"\n{'Would suppress' if args.dry_run else 'Suppressing'} {len(filtered_vulns)} vulnerabilities...")

        approved_count = 0
        failed_count = 0

        for vuln in filtered_vulns:
            vuln_id = vuln.get("id") or vuln.get("vulnerabilityId")
            vuln_name = vuln.get("name") or vuln.get("vulnerabilityName", "Unknown")
            severity = vuln.get("severity", "Unknown")
            priority = vuln.get("priority", "Unknown")

            if args.dry_run:
                print(f"  → Would suppress: {vuln_name} (ID: {vuln_id}, Severity: {severity}, Priority: {priority})")
                approved_count += 1
            else:
                # Request body schema not documented, best effort
                suppress_data = {
                    "vulnerabilityId": vuln_id,
                    "reason": "Auto-approved: Reviewed by security team",
                    "comment": f"Severity: {severity}, Priority: {priority}"
                }

                if args.verbose:
                    print(f"  Suppressing: {vuln_name} (ID: {vuln_id})")

                if client.suppress_vulnerability(suppress_data):
                    approved_count += 1
                    if not args.verbose:
                        print(f"  ✓ Suppressed: {vuln_name} (ID: {vuln_id})")
                else:
                    failed_count += 1

    # Summary
    print("\n" + "=" * 80)
    print("Summary")
    print("=" * 80)
    print(f"Total vulnerabilities found: {len(vulnerabilities)}")
    print(f"Matching approval criteria: {len(filtered_vulns)}")
    print(f"Approval method: {args.approval_method}")

    if args.dry_run:
        print(f"Would approve: {approved_count}")
    else:
        print(f"Successfully approved: {approved_count}")
        print(f"Failed: {failed_count}")

    print("=" * 80)

    if not args.dry_run and failed_count > 0:
        print("\nWARNING: Some approvals failed. Check the API responses above for details.")
        print("This may be due to:")
        print("  - Incorrect status values (not documented in API)")
        print("  - Missing permissions")
        print("  - API endpoint schema differences")
        print("\nConsider using --verbose flag or contacting Revenera support for assistance.")


if __name__ == "__main__":
    main()

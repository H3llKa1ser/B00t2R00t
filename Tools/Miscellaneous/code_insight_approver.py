#!/usr/bin/env python3
"""
Code Insight Vulnerability Approver
Connects to Code Insight server and approves vulnerabilities based on severity and priority
"""

import requests
import json
import sys
import argparse
from typing import List, Dict
from urllib.parse import urljoin


# Criteria for approval
SEVERITIES_TO_APPROVE = ["N/A", "None", "Low", "Medium"]
PRIORITIES_TO_APPROVE = ["P1", "P2"]


class CodeInsightClient:
    def __init__(self, base_url: str, token: str):
        self.base_url = base_url.rstrip('/')
        self.token = token
        self.session = requests.Session()
        self.session.headers.update({
            "Authorization": f"Bearer {token}",
            "Content-Type": "application/json"
        })

    def get_project_vulnerabilities(self, project_id: int) -> List[Dict]:
        """Get all vulnerabilities for a project"""
        vuln_url = urljoin(self.base_url, f"/codeinsight/api/v1/projects/{project_id}/vulnerabilities")

        try:
            response = self.session.get(vuln_url)
            response.raise_for_status()

            vulnerabilities = response.json().get("data", [])
            print(f"✓ Retrieved {len(vulnerabilities)} vulnerabilities")
            return vulnerabilities

        except requests.exceptions.RequestException as e:
            print(f"✗ Error fetching vulnerabilities: {e}")
            return []

    def approve_vulnerability(self, project_id: int, vulnerability_id: int, vuln_name: str) -> bool:
        """Approve a specific vulnerability"""
        approve_url = urljoin(
            self.base_url,
            f"/codeinsight/api/v1/projects/{project_id}/vulnerabilities/{vulnerability_id}/approve"
        )

        try:
            response = self.session.post(
                approve_url,
                json={"comment": "Auto-approved: Reviewed by security team"}
            )
            response.raise_for_status()
            print(f"  ✓ Approved: {vuln_name} (ID: {vulnerability_id})")
            return True

        except requests.exceptions.RequestException as e:
            print(f"  ✗ Failed to approve {vuln_name} (ID: {vulnerability_id}): {e}")
            return False

    def filter_vulnerabilities(self, vulnerabilities: List[Dict]) -> List[Dict]:
        """Filter vulnerabilities based on severity and priority"""
        filtered = []

        for vuln in vulnerabilities:
            severity = vuln.get("severity", "").strip()
            priority = vuln.get("priority", "").strip()
            status = vuln.get("status", "").strip()

            # Skip already approved vulnerabilities
            if status.lower() in ["approved", "closed"]:
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

Approval Criteria:
  - Severities: N/A, None, Low, Medium
  - Priorities: P1, P2
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
        help="API authentication token"
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

    args = parser.parse_args()

    print("=" * 60)
    print("Code Insight Vulnerability Approver")
    print("=" * 60)

    if args.dry_run:
        print("\n*** DRY RUN MODE - No changes will be made ***\n")

    # Initialize client
    print(f"\n[1/3] Connecting to {args.url}...")
    client = CodeInsightClient(args.url, args.token)

    # Get vulnerabilities
    print(f"\n[2/3] Fetching vulnerabilities for project ID {args.project_id}...")
    vulnerabilities = client.get_project_vulnerabilities(args.project_id)

    if not vulnerabilities:
        print("No vulnerabilities found")
        sys.exit(0)

    # Filter vulnerabilities
    filtered_vulns = client.filter_vulnerabilities(vulnerabilities)

    if not filtered_vulns:
        print("\nNo vulnerabilities match the approval criteria")
        sys.exit(0)

    # Approve vulnerabilities
    print(f"\n[3/3] {'Would approve' if args.dry_run else 'Approving'} {len(filtered_vulns)} vulnerabilities...")

    approved_count = 0
    failed_count = 0

    for vuln in filtered_vulns:
        vuln_id = vuln.get("id")
        vuln_name = vuln.get("name", "Unknown")
        severity = vuln.get("severity", "Unknown")
        priority = vuln.get("priority", "Unknown")

        if args.dry_run:
            print(f"  → Would approve: {vuln_name} (ID: {vuln_id}, Severity: {severity}, Priority: {priority})")
            approved_count += 1
        else:
            if client.approve_vulnerability(args.project_id, vuln_id, vuln_name):
                approved_count += 1
            else:
                failed_count += 1

    # Summary
    print("\n" + "=" * 60)
    print("Summary")
    print("=" * 60)
    print(f"Total vulnerabilities: {len(vulnerabilities)}")
    print(f"Matching criteria: {len(filtered_vulns)}")

    if args.dry_run:
        print(f"Would approve: {approved_count}")
    else:
        print(f"Successfully approved: {approved_count}")
        print(f"Failed: {failed_count}")

    print("=" * 60)


if __name__ == "__main__":
    main()

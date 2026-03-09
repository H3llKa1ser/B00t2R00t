# Steps

Step 1: Download & Setup

# Clone or save the script

    chmod +x bugstorm.sh

# Install all dependencies

    ./bugstorm.sh --install

# Verify installation

    ./bugstorm.sh --check

Step 2: Run Your First Scan

# Full recon on a single target

    ./bugstorm.sh -d example.com

# Passive-only recon (safe for initial assessment)

    ./bugstorm.sh -d example.com -s passive

# Active recon with high thread count

    ./bugstorm.sh -d example.com -s active -t 100 -r 5000

# Multi-target scan

    echo -e "target1.com target2.com target3.com" > targets.txt

    ./bugstorm.sh -l targets.txt

# With Discord notifications

    ./bugstorm.sh -d example.com --notify --discord "https://discord.com/api/webhooks/YOUR_WEBHOOK"

Step 3: Review Results

# Results are stored in:

    ~/bugstorm/results/<domain>/<timestamp>/

# View the markdown report

    cat ~/bugstorm/results/example.com/*/reports/report_*.md

# Check for critical vulnerabilities

    cat ~/bugstorm/results/example.com/*/vulns/nuclei_critical.txt

# View discovered secrets

    cat ~/bugstorm/results/example.com/*/js/secrets.txt

# List all live hosts

    cat ~/bugstorm/results/example.com/*/subdomains/live_hosts.txt

Important Notes

•	• Always ensure you have explicit authorization before scanning any target.

•	• Use --scope passive for initial assessment to avoid triggering WAFs or IDS.

•	• Adjust --threads and --rate based on your network and target capacity.

•	• Configure API keys in bugstorm.conf for enhanced subdomain enumeration results.

•	• The tool creates timestamped output directories, so multiple runs won't overwrite previous results.

•	• Review and customize nuclei templates for your specific testing needs.

•	• Use the quick module runner (bugstorm-quick.sh) to re-run specific modules without a full scan.

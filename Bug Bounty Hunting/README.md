# Bugstorm

## Steps

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

# Output Directory Structure

    ~/bugstorm/results/<domain>/<timestamp>/
    ├── subdomains/
    │   ├── subfinder.txt          # Subfinder results
    │   ├── amass.txt              # Amass results
    │   ├── assetfinder.txt        # Assetfinder results
    │   ├── findomain.txt          # Findomain results
    │   ├── crtsh.txt              # Certificate Transparency
    │   ├── shuffledns.txt         # DNS brute-force results
    │   ├── all_subdomains.txt     # Merged & deduplicated
    │   ├── resolved.txt           # DNS-resolved subdomains
    │   ├── resolved_detailed.txt  # With IP addresses
    │   ├── ips.txt                # Unique IP addresses
    │   ├── ip_org_mapping.txt     # IP to organization mapping
    │   ├── live_hosts.txt         # HTTP-responsive hosts
    │   ├── httpx_full.txt         # Full httpx output with metadata
    │   ├── status_200.txt         # 200 OK responses
    │   ├── status_3xx.txt         # Redirect responses
    │   ├── status_auth.txt        # 401/403 responses
    │   └── status_5xx.txt         # Server error responses
    ├── urls/
    │   ├── waybackurls.txt        # Wayback Machine URLs
    │   ├── gau.txt                # GetAllUrls results
    │   ├── katana.txt             # Katana crawler results
    │   ├── hakrawler.txt          # Hakrawler results
    │   ├── all_urls.txt           # All URLs merged
    │   ├── js_files.txt           # JavaScript file URLs
    │   ├── json_endpoints.txt     # JSON endpoints
    │   ├── api_endpoints.txt      # API endpoints
    │   ├── parameterized_urls.txt # URLs with parameters
    │   └── sensitive_files.txt    # Potentially sensitive files
    ├── ports/
    │   ├── naabu.txt              # Fast port scan results
    │   └── nmap_*.txt             # Detailed Nmap scans
    ├── tech/
    │   ├── whatweb.txt            # Technology fingerprints
    │   ├── waf_results.txt        # WAF detection results
    │   └── ssl_analysis.txt       # SSL/TLS analysis
    ├── params/
    │   ├── discovered_params.txt  # Extracted parameters
    │   ├── gf_xss.txt             # XSS-prone URLs
    │   ├── gf_sqli.txt            # SQLi-prone URLs
    │   ├── gf_ssrf.txt            # SSRF-prone URLs
    │   ├── gf_lfi.txt             # LFI-prone URLs
    │   ├── gf_redirect.txt        # Open redirect URLs
    │   ├── gf_idor.txt            # IDOR-prone URLs
    │   ├── gf_rce.txt             # RCE-prone URLs
    │   └── gf_ssti.txt            # SSTI-prone URLs
    ├── js/
    │   ├── downloaded/            # Downloaded JS files
    │   ├── secrets.txt            # Extracted secrets
    │   └── endpoints.txt          # Extracted endpoints
    ├── directories/
    │   └── ffuf_*.json            # Directory brute-force results
    ├── vulns/
    │   ├── nuclei_critical.txt    # Critical severity findings
    │   ├── nuclei_high.txt        # High severity findings
    │   ├── nuclei_medium.txt      # Medium severity findings
    │   ├── nuclei_low.txt         # Low severity findings
    │   ├── nuclei_info.txt        # Informational findings
    │   ├── takeover_results.txt   # Subdomain takeover results
    │   ├── cors_results.txt       # CORS misconfiguration findings
    │   ├── open_redirects.txt     # Open redirect findings
    │   └── missing_headers.txt    # Missing security headers
    ├── nuclei/
    │   └── nuclei_results.txt     # Raw nuclei output
    ├── reports/
    │   ├── report_*.md            # Markdown report
    │   └── report_*.html          # HTML report (if pandoc available)
    └── bugstorm.log               # Full execution log

# Required Tools Summary

| Category          | Tool         | Purpose                                          | Install Method      |
|-------------------|--------------|--------------------------------------------------|---------------------|
| Subdomain Enum    | subfinder    | Passive subdomain enumeration                    | go install          |
| Subdomain Enum    | amass        | Comprehensive subdomain discovery                | go install          |
| Subdomain Enum    | assetfinder  | Asset discovery                                  | go install          |
| Subdomain Enum    | findomain    | Fast subdomain finder                            | Binary download     |
| DNS               | dnsx         | DNS resolution & validation                      | go install          |
| DNS               | massdns      | Mass DNS resolution                              | Compile from source |
| DNS               | shuffledns   | DNS brute-forcing                                | go install          |
| HTTP              | httpx        | HTTP probing & tech detection                    | go install          |
| Ports             | naabu        | Fast port scanning                               | go install          |
| Ports             | nmap         | Detailed port & service scanning                 | apt/yum             |
| URL Discovery     | waybackurls  | Wayback Machine URLs                             | go install          |
| URL Discovery     | gau          | GetAllUrls from multiple sources                 | go install          |
| URL Discovery     | katana       | Web crawling                                     | go install          |
| URL Discovery     | hakrawler    | Web crawling                                     | go install          |
| Dir Busting       | ffuf         | Fast web fuzzer                                  | go install          |
| Dir Busting       | gobuster     | Directory bruteforcing                           | go install          |
| Vuln Scan         | nuclei       | Template-based vulnerability scanning            | go install          |
| Tech Detect       | whatweb      | Web technology fingerprinting                    | apt/yum             |
| WAF               | wafw00f      | WAF detection                                    | pip install         |
| Utility           | gf           | Pattern matching for URLs                        | go install          |
| Utility           | qsreplace    | Query string replacement                         | go install          |
| Utility           | unfurl       | URL parsing                                      | go install          |
| Utility           | anew         | Append new unique lines                          | go install          |
| Utility           | jq           | JSON processing                                  | apt/yum             |


# Important Notes

•	• Always ensure you have explicit authorization before scanning any target.

•	• Use --scope passive for initial assessment to avoid triggering WAFs or IDS.

•	• Adjust --threads and --rate based on your network and target capacity.

•	• Configure API keys in bugstorm.conf for enhanced subdomain enumeration results.

•	• The tool creates timestamped output directories, so multiple runs won't overwrite previous results.

•	• Review and customize nuclei templates for your specific testing needs.

•	• Use the quick module runner (bugstorm-quick.sh) to re-run specific modules without a full scan.

# bugbounty_recon.py

# Full scan with all modules

    python bugbounty_recon.py -d example.com

# Skip slow modules for quick recon

    python bugbounty_recon.py -d example.com --skip ports crawl

# Custom output format and directory

    python bugbounty_recon.py -d example.com -f html json -o results

# Use custom subdomain wordlist

    python bugbounty_recon.py -d example.com -w /path/to/wordlist.txt

# Scan specific ports only

    python bugbounty_recon.py -d example.com --ports 80,443,8080,3000,9200

# Slower, stealthier scanning

    python bugbounty_recon.py -d example.com --rate-limit 1.0 --timeout 15

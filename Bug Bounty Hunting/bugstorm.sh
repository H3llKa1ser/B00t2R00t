#!/usr/bin/env bash
# ============================================================================
# BugStorm v2.0 — Advanced Bug Bounty Reconnaissance Framework
# Author : BugStorm Framework
# License : MIT
# Requires: See install_dependencies() for full list
# ============================================================================

set -euo pipefail
IFS=$'\n\t'

# ──────────────────────────── GLOBAL CONFIG ────────────────────────────
readonly VERSION="2.0"
readonly BOLD="\e[1m"
readonly RED="\e[31m"
readonly GREEN="\e[32m"
readonly YELLOW="\e[33m"
readonly BLUE="\e[34m"
readonly MAGENTA="\e[35m"
readonly CYAN="\e[36m"
readonly RESET="\e[0m"

# Defaults (overridable via flags)
THREADS=50
RATE_LIMIT=1000
RESOLVERS="$HOME/bugstorm/wordlists/resolvers.txt"
WORDLIST="$HOME/bugstorm/wordlists/subdomains.txt"
TIMEOUT=10
SCOPE="full"           # full | passive | active
NOTIFY=false
DISCORD_WEBHOOK=""
SLACK_WEBHOOK=""
TIMESTAMP=$(date +%Y%m%d_%H%M%S)

# ──────────────────────────── BANNER ───────────────────────────────────
banner() {
    echo -e "${CYAN}"
    cat << 'EOF'
    ____              _____ __
   / __ )__  ______ / ___// /_____  _________ ___
  / __  / / / / __ \\__ \/ __/ __ \/ ___/ __ `__ \
 / /_/ / /_/ / /_/ /__/ / /_/ /_/ / /  / / / / / /
/_____/\__,_/\__, /____/\__/\____/_/  /_/ /_/ /_/
            /____/
         Advanced Recon Framework v2.0
EOF
    echo -e "${RESET}"
}

# ──────────────────────────── LOGGING ──────────────────────────────────
log_info()    { echo -e "${BLUE}[INFO]${RESET}    $(date '+%H:%M:%S') — $*"; }
log_success() { echo -e "${GREEN}[SUCCESS]${RESET} $(date '+%H:%M:%S') — $*"; }
log_warn()    { echo -e "${YELLOW}[WARN]${RESET}    $(date '+%H:%M:%S') — $*"; }
log_error()   { echo -e "${RED}[ERROR]${RESET}   $(date '+%H:%M:%S') — $*"; }
log_step()    { echo -e "\n${MAGENTA}${BOLD}═══════════════════════════════════════════════${RESET}"; \
                echo -e "${MAGENTA}${BOLD}  ▶  $*${RESET}"; \
                echo -e "${MAGENTA}${BOLD}═══════════════════════════════════════════════${RESET}\n"; }

# ──────────────────────────── NOTIFICATIONS ────────────────────────────
notify() {
    local message="$1"
    if [[ "$NOTIFY" == true ]]; then
        if [[ -n "$DISCORD_WEBHOOK" ]]; then
            curl -s -H "Content-Type: application/json" \
                 -d "{\"content\":\"$message\"}" \
                 "$DISCORD_WEBHOOK" > /dev/null 2>&1 &
        fi
        if [[ -n "$SLACK_WEBHOOK" ]]; then
            curl -s -H "Content-Type: application/json" \
                 -d "{\"text\":\"$message\"}" \
                 "$SLACK_WEBHOOK" > /dev/null 2>&1 &
        fi
    fi
}

# ──────────────────────────── DEPENDENCY CHECK ─────────────────────────
check_tool() {
    if command -v "$1" &>/dev/null; then
        echo -e "  ${GREEN}✔${RESET} $1"
        return 0
    else
        echo -e "  ${RED}✘${RESET} $1 (missing)"
        return 1
    fi
}

check_dependencies() {
    log_step "Checking Dependencies"
    local missing=0
    local tools=(
        subfinder amass assetfinder findomain
        httpx naabu nuclei
        waybackurls gau hakrawler katana
        ffuf gobuster feroxbuster
        dnsx massdns shuffledns
        nmap whatweb wafw00f
        jq anew curl openssl
        gf qsreplace unfurl
    )

    for tool in "${tools[@]}"; do
        check_tool "$tool" || ((missing++))
    done

    if [[ $missing -gt 0 ]]; then
        log_warn "$missing tool(s) missing. Some modules may be skipped."
        log_warn "Run: $0 --install to install all dependencies."
    else
        log_success "All dependencies satisfied!"
    fi
}

# ──────────────────────────── INSTALLER ────────────────────────────────
install_dependencies() {
    log_step "Installing Dependencies"

    # Go tools
    go_tools=(
        "github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest"
        "github.com/projectdiscovery/httpx/cmd/httpx@latest"
        "github.com/projectdiscovery/naabu/v2/cmd/naabu@latest"
        "github.com/projectdiscovery/nuclei/v3/cmd/nuclei@latest"
        "github.com/projectdiscovery/dnsx/cmd/dnsx@latest"
        "github.com/projectdiscovery/katana/cmd/katana@latest"
        "github.com/projectdiscovery/shuffledns/cmd/shuffledns@latest"
        "github.com/tomnomnom/waybackurls@latest"
        "github.com/tomnomnom/gf@latest"
        "github.com/tomnomnom/anew@latest"
        "github.com/tomnomnom/unfurl@latest"
        "github.com/lc/gau/v2/cmd/gau@latest"
        "github.com/hakluke/hakrawler@latest"
        "github.com/tomnomnom/qsreplace@latest"
        "github.com/ffuf/ffuf/v2@latest"
        "github.com/OJ/gobuster/v3@latest"
        "github.com/epi052/feroxbuster@latest"
        "github.com/OWASP/Amass/v4/...@master"
    )

    for tool in "${go_tools[@]}"; do
        log_info "Installing $tool ..."
        go install "$tool" 2>/dev/null || log_warn "Failed: $tool"
    done

    # Findomain
    if ! command -v findomain &>/dev/null; then
        log_info "Installing findomain..."
        curl -LO https://github.com/findomain/findomain/releases/latest/download/findomain-linux.zip
        unzip -o findomain-linux.zip -d /usr/local/bin/ && rm findomain-linux.zip
        chmod +x /usr/local/bin/findomain
    fi

    # MassDNS
    if ! command -v massdns &>/dev/null; then
        log_info "Installing massdns..."
        git clone https://github.com/blechschmidt/massdns.git /tmp/massdns
        cd /tmp/massdns && make && cp bin/massdns /usr/local/bin/ && cd -
    fi

    # System packages
    log_info "Installing system packages..."
    sudo apt-get update -qq
    sudo apt-get install -y -qq nmap whatweb wafw00f jq openssl dnsutils 2>/dev/null \
        || sudo yum install -y nmap jq openssl bind-utils 2>/dev/null \
        || log_warn "Install system packages manually."

    # Wordlists
    setup_wordlists

    log_success "Installation complete!"
}

# ──────────────────────────── WORDLISTS ────────────────────────────────
setup_wordlists() {
    local wl_dir="$HOME/bugstorm/wordlists"
    mkdir -p "$wl_dir"

    if [[ ! -f "$wl_dir/subdomains.txt" ]]; then
        log_info "Downloading subdomain wordlist..."
        curl -sL "https://raw.githubusercontent.com/danielmiessler/SecLists/master/Discovery/DNS/subdomains-top1million-20000.txt" \
            -o "$wl_dir/subdomains.txt"
    fi

    if [[ ! -f "$wl_dir/resolvers.txt" ]]; then
        log_info "Downloading fresh resolvers..."
        curl -sL "https://raw.githubusercontent.com/trickest/resolvers/main/resolvers-trusted.txt" \
            -o "$wl_dir/resolvers.txt"
    fi

    if [[ ! -f "$wl_dir/dirsearch.txt" ]]; then
        log_info "Downloading directory wordlist..."
        curl -sL "https://raw.githubusercontent.com/danielmiessler/SecLists/master/Discovery/Web-Content/raft-medium-directories.txt" \
            -o "$wl_dir/dirsearch.txt"
    fi

    if [[ ! -f "$wl_dir/params.txt" ]]; then
        log_info "Downloading parameter wordlist..."
        curl -sL "https://raw.githubusercontent.com/danielmiessler/SecLists/master/Discovery/Web-Content/burp-parameter-names.txt" \
            -o "$wl_dir/params.txt"
    fi
}

# ──────────────────────────── OUTPUT SETUP ─────────────────────────────
setup_output() {
    local domain="$1"
    OUTDIR="$HOME/bugstorm/results/${domain}/${TIMESTAMP}"
    mkdir -p "$OUTDIR"/{subdomains,urls,ports,screenshots,nuclei,directories,vulns,js,params,tech,reports}

    # Master log
    LOGFILE="$OUTDIR/bugstorm.log"
    exec > >(tee -a "$LOGFILE") 2>&1

    log_info "Output directory: $OUTDIR"
}

# ════════════════════════════════════════════════════════════════════════
# MODULE 1: SUBDOMAIN ENUMERATION
# ════════════════════════════════════════════════════════════════════════
module_subdomains() {
    local domain="$1"
    local sub_dir="$OUTDIR/subdomains"
    log_step "MODULE 1: Subdomain Enumeration — $domain"

    # --- 1a. Subfinder ---
    if command -v subfinder &>/dev/null; then
        log_info "Running subfinder..."
        subfinder -d "$domain" -all -silent -t "$THREADS" \
            -o "$sub_dir/subfinder.txt" 2>/dev/null
        log_success "subfinder: $(wc -l < "$sub_dir/subfinder.txt" 2>/dev/null || echo 0) subdomains"
    fi

    # --- 1b. Amass (passive) ---
    if command -v amass &>/dev/null; then
        log_info "Running amass (passive)..."
        timeout 600 amass enum -passive -d "$domain" \
            -o "$sub_dir/amass.txt" 2>/dev/null || true
        log_success "amass: $(wc -l < "$sub_dir/amass.txt" 2>/dev/null || echo 0) subdomains"
    fi

    # --- 1c. Assetfinder ---
    if command -v assetfinder &>/dev/null; then
        log_info "Running assetfinder..."
        assetfinder --subs-only "$domain" > "$sub_dir/assetfinder.txt" 2>/dev/null
        log_success "assetfinder: $(wc -l < "$sub_dir/assetfinder.txt" 2>/dev/null || echo 0) subdomains"
    fi

    # --- 1d. Findomain ---
    if command -v findomain &>/dev/null; then
        log_info "Running findomain..."
        findomain -t "$domain" -u "$sub_dir/findomain.txt" --quiet 2>/dev/null || true
        log_success "findomain: $(wc -l < "$sub_dir/findomain.txt" 2>/dev/null || echo 0) subdomains"
    fi

    # --- 1e. crt.sh (Certificate Transparency) ---
    log_info "Querying crt.sh..."
    curl -s "https://crt.sh/?q=%25.$domain&output=json" 2>/dev/null \
        | jq -r '.[].name_value' 2>/dev/null \
        | sed 's/\*\.//g' \
        | sort -u > "$sub_dir/crtsh.txt" || true
    log_success "crt.sh: $(wc -l < "$sub_dir/crtsh.txt" 2>/dev/null || echo 0) subdomains"

    # --- 1f. Brute-force with ShuffleDNS ---
    if [[ "$SCOPE" == "full" || "$SCOPE" == "active" ]]; then
        if command -v shuffledns &>/dev/null && [[ -f "$WORDLIST" ]]; then
            log_info "Running shuffledns bruteforce..."
            shuffledns -d "$domain" -w "$WORDLIST" -r "$RESOLVERS" \
                -t "$THREADS" -o "$sub_dir/shuffledns.txt" 2>/dev/null || true
            log_success "shuffledns: $(wc -l < "$sub_dir/shuffledns.txt" 2>/dev/null || echo 0) subdomains"
        fi
    fi

    # --- Merge & Deduplicate ---
    log_info "Merging and deduplicating subdomains..."
    cat "$sub_dir"/*.txt 2>/dev/null \
        | grep -E "^[a-zA-Z0-9]" \
        | grep -i "\.${domain}$" \
        | sort -u \
        | tr '[:upper:]' '[:lower:]' \
        > "$sub_dir/all_subdomains.txt"

    local total
    total=$(wc -l < "$sub_dir/all_subdomains.txt")
    log_success "TOTAL unique subdomains: $total"
    notify "🔍 BugStorm [$domain]: Found $total unique subdomains"
}

# ════════════════════════════════════════════════════════════════════════
# MODULE 2: DNS RESOLUTION & FILTERING
# ════════════════════════════════════════════════════════════════════════
module_dns_resolution() {
    local domain="$1"
    local sub_dir="$OUTDIR/subdomains"
    log_step "MODULE 2: DNS Resolution — $domain"

    if command -v dnsx &>/dev/null; then
        log_info "Resolving subdomains with dnsx..."
        cat "$sub_dir/all_subdomains.txt" \
            | dnsx -silent -a -resp -t "$THREADS" \
            -o "$sub_dir/resolved_detailed.txt" 2>/dev/null

        cat "$sub_dir/all_subdomains.txt" \
            | dnsx -silent -t "$THREADS" \
            > "$sub_dir/resolved.txt" 2>/dev/null

        # Extract IPs
        cat "$sub_dir/resolved_detailed.txt" 2>/dev/null \
            | grep -oP '\d+\.\d+\.\d+\.\d+' \
            | sort -u > "$sub_dir/ips.txt"

        # Identify CDN / cloud ranges
        log_info "Checking for CDN/Cloud IPs..."
        while IFS= read -r ip; do
            local org
            org=$(curl -s "https://ipinfo.io/$ip/org" 2>/dev/null || echo "unknown")
            echo "$ip — $org" >> "$sub_dir/ip_org_mapping.txt"
        done < <(head -100 "$sub_dir/ips.txt")

        local resolved_count
        resolved_count=$(wc -l < "$sub_dir/resolved.txt" 2>/dev/null || echo 0)
        log_success "Resolved subdomains: $resolved_count"
        log_success "Unique IPs: $(wc -l < "$sub_dir/ips.txt" 2>/dev/null || echo 0)"
    else
        log_warn "dnsx not found, copying all subdomains as resolved..."
        cp "$sub_dir/all_subdomains.txt" "$sub_dir/resolved.txt"
    fi
}

# ════════════════════════════════════════════════════════════════════════
# MODULE 3: HTTP PROBING
# ════════════════════════════════════════════════════════════════════════
module_http_probe() {
    local domain="$1"
    local sub_dir="$OUTDIR/subdomains"
    log_step "MODULE 3: HTTP Probing — $domain"

    if command -v httpx &>/dev/null; then
        log_info "Probing live hosts with httpx..."
        cat "$sub_dir/resolved.txt" \
            | httpx -silent -t "$THREADS" \
                -status-code -content-length -title -tech-detect \
                -follow-redirects -timeout "$TIMEOUT" \
                -o "$sub_dir/httpx_full.txt" 2>/dev/null

        # Extract just live URLs
        cat "$sub_dir/httpx_full.txt" \
            | awk '{print $1}' \
            | sort -u > "$sub_dir/live_hosts.txt"

        # Categorize by status code
        grep -E "\[200\]" "$sub_dir/httpx_full.txt" > "$sub_dir/status_200.txt" 2>/dev/null || true
        grep -E "\[301\]|\[302\]|\[303\]|\[307\]|\[308\]" "$sub_dir/httpx_full.txt" > "$sub_dir/status_3xx.txt" 2>/dev/null || true
        grep -E "\[401\]|\[403\]" "$sub_dir/httpx_full.txt" > "$sub_dir/status_auth.txt" 2>/dev/null || true
        grep -E "\[404\]" "$sub_dir/httpx_full.txt" > "$sub_dir/status_404.txt" 2>/dev/null || true
        grep -E "\[500\]|\[502\]|\[503\]" "$sub_dir/httpx_full.txt" > "$sub_dir/status_5xx.txt" 2>/dev/null || true

        local live
        live=$(wc -l < "$sub_dir/live_hosts.txt" 2>/dev/null || echo 0)
        log_success "Live hosts: $live"
        notify "🌐 BugStorm [$domain]: $live live hosts discovered"
    fi
}

# ════════════════════════════════════════════════════════════════════════
# MODULE 4: PORT SCANNING
# ════════════════════════════════════════════════════════════════════════
module_port_scan() {
    local domain="$1"
    local port_dir="$OUTDIR/ports"
    local sub_dir="$OUTDIR/subdomains"
    log_step "MODULE 4: Port Scanning — $domain"

    if [[ "$SCOPE" != "full" && "$SCOPE" != "active" ]]; then
        log_warn "Skipping port scan (passive mode)"
        return
    fi

    # --- 4a. Naabu (fast port scan) ---
    if command -v naabu &>/dev/null; then
        log_info "Running naabu (top 1000 ports)..."
        cat "$sub_dir/resolved.txt" \
            | naabu -silent -top-ports 1000 -rate "$RATE_LIMIT" \
                -t "$THREADS" -o "$port_dir/naabu.txt" 2>/dev/null || true
        log_success "naabu: $(wc -l < "$port_dir/naabu.txt" 2>/dev/null || echo 0) open ports"
    fi

    # --- 4b. Nmap (detailed scan on discovered ports) ---
    if command -v nmap &>/dev/null && [[ -f "$sub_dir/ips.txt" ]]; then
        log_info "Running nmap service detection on top IPs..."
        head -20 "$sub_dir/ips.txt" \
            | xargs -I{} -P 5 nmap -sV -sC --top-ports 100 -T4 \
                -oN "$port_dir/nmap_{}.txt" {} 2>/dev/null || true
        log_success "nmap scans complete"
    fi
}

# ════════════════════════════════════════════════════════════════════════
# MODULE 5: TECHNOLOGY DETECTION
# ════════════════════════════════════════════════════════════════════════
module_tech_detect() {
    local domain="$1"
    local tech_dir="$OUTDIR/tech"
    local sub_dir="$OUTDIR/subdomains"
    log_step "MODULE 5: Technology Detection — $domain"

    # --- 5a. WhatWeb ---
    if command -v whatweb &>/dev/null && [[ -f "$sub_dir/live_hosts.txt" ]]; then
        log_info "Running whatweb..."
        while IFS= read -r url; do
            whatweb "$url" --color=never -q >> "$tech_dir/whatweb.txt" 2>/dev/null || true
        done < <(head -50 "$sub_dir/live_hosts.txt")
        log_success "whatweb analysis complete"
    fi

    # --- 5b. WAF Detection ---
    if command -v wafw00f &>/dev/null && [[ -f "$sub_dir/live_hosts.txt" ]]; then
        log_info "Running wafw00f..."
        while IFS= read -r url; do
            wafw00f "$url" -o "$tech_dir/waf_$(echo "$url" | md5sum | cut -c1-8).txt" 2>/dev/null || true
        done < <(head -30 "$sub_dir/live_hosts.txt")

        cat "$tech_dir"/waf_*.txt 2>/dev/null | sort -u > "$tech_dir/waf_results.txt"
        log_success "WAF detection complete"
    fi

    # --- 5c. SSL/TLS Analysis ---
    log_info "Analyzing SSL/TLS configurations..."
    while IFS= read -r subdomain; do
        local host
        host=$(echo "$subdomain" | sed 's|https\?://||' | cut -d'/' -f1)
        echo "=== $host ===" >> "$tech_dir/ssl_analysis.txt"
        echo | openssl s_client -connect "$host:443" -servername "$host" 2>/dev/null \
            | openssl x509 -noout -dates -subject -issuer \
            >> "$tech_dir/ssl_analysis.txt" 2>/dev/null || true
    done < <(head -30 "$sub_dir/live_hosts.txt" 2>/dev/null)
    log_success "SSL/TLS analysis complete"
}

# ════════════════════════════════════════════════════════════════════════
# MODULE 6: URL & ENDPOINT DISCOVERY
# ════════════════════════════════════════════════════════════════════════
module_url_discovery() {
    local domain="$1"
    local url_dir="$OUTDIR/urls"
    local sub_dir="$OUTDIR/subdomains"
    log_step "MODULE 6: URL & Endpoint Discovery — $domain"

    # --- 6a. Wayback URLs ---
    if command -v waybackurls &>/dev/null; then
        log_info "Fetching wayback URLs..."
        cat "$sub_dir/resolved.txt" \
            | waybackurls > "$url_dir/waybackurls.txt" 2>/dev/null || true
        log_success "waybackurls: $(wc -l < "$url_dir/waybackurls.txt" 2>/dev/null || echo 0) URLs"
    fi

    # --- 6b. GAU (GetAllUrls) ---
    if command -v gau &>/dev/null; then
        log_info "Fetching URLs with gau..."
        cat "$sub_dir/resolved.txt" \
            | gau --threads "$THREADS" --timeout "$TIMEOUT" \
            > "$url_dir/gau.txt" 2>/dev/null || true
        log_success "gau: $(wc -l < "$url_dir/gau.txt" 2>/dev/null || echo 0) URLs"
    fi

    # --- 6c. Katana (web crawling) ---
    if command -v katana &>/dev/null && [[ -f "$sub_dir/live_hosts.txt" ]]; then
        log_info "Crawling with katana..."
        katana -list "$sub_dir/live_hosts.txt" \
            -d 3 -jc -kf -silent -t "$THREADS" \
            -o "$url_dir/katana.txt" 2>/dev/null || true
        log_success "katana: $(wc -l < "$url_dir/katana.txt" 2>/dev/null || echo 0) URLs"
    fi

    # --- 6d. Hakrawler ---
    if command -v hakrawler &>/dev/null && [[ -f "$sub_dir/live_hosts.txt" ]]; then
        log_info "Crawling with hakrawler..."
        cat "$sub_dir/live_hosts.txt" \
            | hakrawler -d 3 -t "$THREADS" \
            > "$url_dir/hakrawler.txt" 2>/dev/null || true
        log_success "hakrawler: $(wc -l < "$url_dir/hakrawler.txt" 2>/dev/null || echo 0) URLs"
    fi

    # --- Merge all URLs ---
    log_info "Merging and deduplicating all URLs..."
    cat "$url_dir"/*.txt 2>/dev/null | sort -u > "$url_dir/all_urls.txt"

    # --- Classify URLs ---
    log_info "Classifying URLs..."
    grep -iE "\.js(\?|$)" "$url_dir/all_urls.txt" > "$url_dir/js_files.txt" 2>/dev/null || true
    grep -iE "\.json(\?|$)" "$url_dir/all_urls.txt" > "$url_dir/json_endpoints.txt" 2>/dev/null || true
    grep -iE "\.xml(\?|$)" "$url_dir/all_urls.txt" > "$url_dir/xml_files.txt" 2>/dev/null || true
    grep -iE "\.php(\?|$)" "$url_dir/all_urls.txt" > "$url_dir/php_files.txt" 2>/dev/null || true
    grep -iE "\.asp[x]?(\?|$)" "$url_dir/all_urls.txt" > "$url_dir/asp_files.txt" 2>/dev/null || true
    grep -iE "\.(zip|tar|gz|rar|bak|sql|db|log|env|cfg|conf|ini)" "$url_dir/all_urls.txt" \
        > "$url_dir/sensitive_files.txt" 2>/dev/null || true
    grep -iE "(api|graphql|rest|v[0-9])" "$url_dir/all_urls.txt" > "$url_dir/api_endpoints.txt" 2>/dev/null || true
    grep -iE "\?" "$url_dir/all_urls.txt" > "$url_dir/parameterized_urls.txt" 2>/dev/null || true

    local total
    total=$(wc -l < "$url_dir/all_urls.txt" 2>/dev/null || echo 0)
    log_success "TOTAL unique URLs: $total"
    log_success "  JS files:          $(wc -l < "$url_dir/js_files.txt" 2>/dev/null || echo 0)"
    log_success "  API endpoints:     $(wc -l < "$url_dir/api_endpoints.txt" 2>/dev/null || echo 0)"
    log_success "  Parameterized:     $(wc -l < "$url_dir/parameterized_urls.txt" 2>/dev/null || echo 0)"
    log_success "  Sensitive files:   $(wc -l < "$url_dir/sensitive_files.txt" 2>/dev/null || echo 0)"
    notify "🔗 BugStorm [$domain]: $total unique URLs found"
}

# ════════════════════════════════════════════════════════════════════════
# MODULE 7: PARAMETER DISCOVERY
# ════════════════════════════════════════════════════════════════════════
module_param_discovery() {
    local domain="$1"
    local param_dir="$OUTDIR/params"
    local url_dir="$OUTDIR/urls"
    log_step "MODULE 7: Parameter Discovery — $domain"

    # --- Extract parameters from URLs ---
    if command -v unfurl &>/dev/null && [[ -f "$url_dir/parameterized_urls.txt" ]]; then
        log_info "Extracting parameters with unfurl..."
        cat "$url_dir/parameterized_urls.txt" \
            | unfurl keys \
            | sort -u > "$param_dir/discovered_params.txt" 2>/dev/null || true
        log_success "Unique parameters: $(wc -l < "$param_dir/discovered_params.txt" 2>/dev/null || echo 0)"
    fi

    # --- GF patterns for vulnerability classes ---
    if command -v gf &>/dev/null && [[ -f "$url_dir/parameterized_urls.txt" ]]; then
        log_info "Applying GF patterns..."
        local patterns=(xss ssrf sqli lfi redirect idor rce ssti debug)
        for pattern in "${patterns[@]}"; do
            cat "$url_dir/parameterized_urls.txt" \
                | gf "$pattern" > "$param_dir/gf_${pattern}.txt" 2>/dev/null || true
            local count
            count=$(wc -l < "$param_dir/gf_${pattern}.txt" 2>/dev/null || echo 0)
            [[ $count -gt 0 ]] && log_success "  GF $pattern: $count URLs"
        done
    fi
}

# ════════════════════════════════════════════════════════════════════════
# MODULE 8: JAVASCRIPT ANALYSIS
# ════════════════════════════════════════════════════════════════════════
module_js_analysis() {
    local domain="$1"
    local js_dir="$OUTDIR/js"
    local url_dir="$OUTDIR/urls"
    log_step "MODULE 8: JavaScript Analysis — $domain"

    if [[ ! -f "$url_dir/js_files.txt" ]] || [[ ! -s "$url_dir/js_files.txt" ]]; then
        log_warn "No JS files found, skipping..."
        return
    fi

    # --- Download JS files ---
    log_info "Downloading JS files..."
    mkdir -p "$js_dir/downloaded"
    local count=0
    while IFS= read -r js_url && [[ $count -lt 200 ]]; do
        local filename
        filename=$(echo "$js_url" | md5sum | cut -c1-12)
        curl -sL --max-time 10 "$js_url" -o "$js_dir/downloaded/${filename}.js" 2>/dev/null || true
        ((count++))
    done < "$url_dir/js_files.txt"
    log_success "Downloaded $count JS files"

    # --- Extract secrets from JS ---
    log_info "Scanning JS files for secrets..."
    {
        echo "=== API Keys & Tokens ==="
        grep -rhoP "(api[_-]?key|api[_-]?secret|access[_-]?token|auth[_-]?token|bearer)\s*[:=]\s*['\"][a-zA-Z0-9_\-]{16,}['\"]" "$js_dir/downloaded/" 2>/dev/null || true

        echo ""
        echo "=== AWS Keys ==="
        grep -rhoP "(AKIA[0-9A-Z]{16})" "$js_dir/downloaded/" 2>/dev/null || true

        echo ""
        echo "=== Private Keys ==="
        grep -rhoP "-----BEGIN (RSA |EC |DSA )?PRIVATE KEY-----" "$js_dir/downloaded/" 2>/dev/null || true

        echo ""
        echo "=== Internal URLs ==="
        grep -rhoP "https?://[a-zA-Z0-9._\-]+\.(internal|local|dev|staging|test)[a-zA-Z0-9./?=&_\-]*" "$js_dir/downloaded/" 2>/dev/null || true

        echo ""
        echo "=== Email Addresses ==="
        grep -rhoP "[a-zA-Z0-9._%+\-]+@[a-zA-Z0-9.\-]+\.[a-zA-Z]{2,}" "$js_dir/downloaded/" 2>/dev/null || true

        echo ""
        echo "=== Hardcoded Passwords ==="
        grep -rhoP "(password|passwd|pwd)\s*[:=]\s*['\"][^'\"]{4,}['\"]" "$js_dir/downloaded/" 2>/dev/null || true

        echo ""
        echo "=== Cloud Storage URLs ==="
        grep -rhoP "(https?://[a-zA-Z0-9_\-]+\.s3\.amazonaws\.com|https?://storage\.googleapis\.com/[a-zA-Z0-9_\-]+)" "$js_dir/downloaded/" 2>/dev/null || true
    } > "$js_dir/secrets.txt"

    # --- Extract endpoints from JS ---
    log_info "Extracting endpoints from JS files..."
    grep -rhoP "[\"\']\/[a-zA-Z0-9_\-/]+[\"\']" "$js_dir/downloaded/" 2>/dev/null \
        | sed "s/['\"]//g" \
        | sort -u > "$js_dir/endpoints.txt" || true

    log_success "JS Secrets found: $(grep -c '[a-zA-Z]' "$js_dir/secrets.txt" 2>/dev/null || echo 0) lines"
    log_success "JS Endpoints found: $(wc -l < "$js_dir/endpoints.txt" 2>/dev/null || echo 0)"
}

# ════════════════════════════════════════════════════════════════════════
# MODULE 9: DIRECTORY BRUTEFORCING
# ════════════════════════════════════════════════════════════════════════
module_dir_bruteforce() {
    local domain="$1"
    local dir_dir="$OUTDIR/directories"
    local sub_dir="$OUTDIR/subdomains"
    local dir_wordlist="$HOME/bugstorm/wordlists/dirsearch.txt"
    log_step "MODULE 9: Directory Bruteforcing — $domain"

    if [[ "$SCOPE" == "passive" ]]; then
        log_warn "Skipping directory bruteforce (passive mode)"
        return
    fi

    if [[ ! -f "$dir_wordlist" ]]; then
        log_warn "Directory wordlist not found, skipping..."
        return
    fi

    # Use ffuf on top live hosts
    if command -v ffuf &>/dev/null && [[ -f "$sub_dir/live_hosts.txt" ]]; then
        log_info "Running ffuf on top targets..."
        local count=0
        while IFS= read -r url && [[ $count -lt 15 ]]; do
            local host
            host=$(echo "$url" | sed 's|https\?://||' | cut -d'/' -f1 | tr '.' '_')
            log_info "  ffuf -> $url"
            ffuf -u "${url}/FUZZ" -w "$dir_wordlist" \
                -t "$THREADS" -timeout "$TIMEOUT" \
                -mc 200,201,301,302,307,401,403,405 \
                -fc 404 -ac \
                -o "$dir_dir/ffuf_${host}.json" \
                -of json -s 2>/dev/null || true
            ((count++))
        done < "$sub_dir/live_hosts.txt"
        log_success "ffuf bruteforce complete ($count targets)"
    fi
}

# ════════════════════════════════════════════════════════════════════════
# MODULE 10: VULNERABILITY SCANNING
# ════════════════════════════════════════════════════════════════════════
module_vuln_scan() {
    local domain="$1"
    local vuln_dir="$OUTDIR/vulns"
    local sub_dir="$OUTDIR/subdomains"
    local url_dir="$OUTDIR/urls"
    local param_dir="$OUTDIR/params"
    log_step "MODULE 10: Vulnerability Scanning — $domain"

    # --- 10a. Nuclei ---
    if command -v nuclei &>/dev/null && [[ -f "$sub_dir/live_hosts.txt" ]]; then
        log_info "Updating nuclei templates..."
        nuclei -update-templates -silent 2>/dev/null || true

        log_info "Running nuclei (all severity levels)..."
        nuclei -l "$sub_dir/live_hosts.txt" \
            -t "$HOME/nuclei-templates/" \
            -severity critical,high,medium,low,info \
            -c "$THREADS" -timeout "$TIMEOUT" \
            -o "$OUTDIR/nuclei/nuclei_results.txt" \
            -silent 2>/dev/null || true

        # Categorize by severity
        grep -i "\[critical\]" "$OUTDIR/nuclei/nuclei_results.txt" > "$vuln_dir/nuclei_critical.txt" 2>/dev/null || true
        grep -i "\[high\]" "$OUTDIR/nuclei/nuclei_results.txt" > "$vuln_dir/nuclei_high.txt" 2>/dev/null || true
        grep -i "\[medium\]" "$OUTDIR/nuclei/nuclei_results.txt" > "$vuln_dir/nuclei_medium.txt" 2>/dev/null || true
        grep -i "\[low\]" "$OUTDIR/nuclei/nuclei_results.txt" > "$vuln_dir/nuclei_low.txt" 2>/dev/null || true
        grep -i "\[info\]" "$OUTDIR/nuclei/nuclei_results.txt" > "$vuln_dir/nuclei_info.txt" 2>/dev/null || true

        log_success "Nuclei results:"
        log_success "  Critical: $(wc -l < "$vuln_dir/nuclei_critical.txt" 2>/dev/null || echo 0)"
        log_success "  High:     $(wc -l < "$vuln_dir/nuclei_high.txt" 2>/dev/null || echo 0)"
        log_success "  Medium:   $(wc -l < "$vuln_dir/nuclei_medium.txt" 2>/dev/null || echo 0)"
        log_success "  Low:      $(wc -l < "$vuln_dir/nuclei_low.txt" 2>/dev/null || echo 0)"
        log_success "  Info:     $(wc -l < "$vuln_dir/nuclei_info.txt" 2>/dev/null || echo 0)"
    fi

    # --- 10b. Subdomain Takeover Check ---
    log_info "Checking for subdomain takeovers..."
    if command -v nuclei &>/dev/null; then
        nuclei -l "$sub_dir/resolved.txt" \
            -t "$HOME/nuclei-templates/http/takeovers/" \
            -c "$THREADS" -silent \
            -o "$vuln_dir/takeover_results.txt" 2>/dev/null || true

        local takeovers
        takeovers=$(wc -l < "$vuln_dir/takeover_results.txt" 2>/dev/null || echo 0)
        [[ $takeovers -gt 0 ]] && notify "🚨 BugStorm [$domain]: $takeovers potential subdomain takeovers!"
    fi

    # --- 10c. CORS Misconfiguration ---
    log_info "Checking CORS misconfigurations..."
    while IFS= read -r url && [[ $(wc -l < "$vuln_dir/cors_results.txt" 2>/dev/null || echo 0) -lt 500 ]]; do
        local response
        response=$(curl -sI -H "Origin: https://evil.com" "$url" 2>/dev/null || true)
        if echo "$response" | grep -qi "access-control-allow-origin: https://evil.com"; then
            echo "[CORS VULN] $url" >> "$vuln_dir/cors_results.txt"
        fi
    done < <(head -50 "$sub_dir/live_hosts.txt" 2>/dev/null)
    log_success "CORS check: $(wc -l < "$vuln_dir/cors_results.txt" 2>/dev/null || echo 0) findings"

    # --- 10d. Open Redirect Check ---
    if [[ -f "$param_dir/gf_redirect.txt" ]]; then
        log_info "Checking open redirects..."
        if command -v qsreplace &>/dev/null; then
            cat "$param_dir/gf_redirect.txt" \
                | qsreplace "https://evil.com" \
                | while IFS= read -r url; do
                    local location
                    location=$(curl -sI -L --max-redirs 3 "$url" 2>/dev/null | grep -i "^location:" | tail -1 || true)
                    if echo "$location" | grep -qi "evil.com"; then
                        echo "[OPEN REDIRECT] $url" >> "$vuln_dir/open_redirects.txt"
                    fi
                done
        fi
        log_success "Open redirect check: $(wc -l < "$vuln_dir/open_redirects.txt" 2>/dev/null || echo 0) findings"
    fi

    # --- 10e. Header Security Analysis ---
    log_info "Analyzing security headers..."
    while IFS= read -r url; do
        local headers
        headers=$(curl -sI --max-time 5 "$url" 2>/dev/null || true)
        local missing=""
        echo "$headers" | grep -qi "strict-transport-security" || missing="${missing}HSTS,"
        echo "$headers" | grep -qi "x-content-type-options" || missing="${missing}X-Content-Type,"
        echo "$headers" | grep -qi "x-frame-options" || missing="${missing}X-Frame,"
        echo "$headers" | grep -qi "content-security-policy" || missing="${missing}CSP,"
        echo "$headers" | grep -qi "x-xss-protection" || missing="${missing}X-XSS,"
        [[ -n "$missing" ]] && echo "$url — Missing: $missing" >> "$vuln_dir/missing_headers.txt"
    done < <(head -50 "$sub_dir/live_hosts.txt" 2>/dev/null)
    log_success "Security header check complete"

    notify "🎯 BugStorm [$domain]: Vulnerability scanning complete!"
}

# ════════════════════════════════════════════════════════════════════════
# MODULE 11: REPORT GENERATION
# ════════════════════════════════════════════════════════════════════════
module_report() {
    local domain="$1"
    local report_dir="$OUTDIR/reports"
    log_step "MODULE 11: Report Generation — $domain"

    local report="$report_dir/report_${domain}_${TIMESTAMP}.md"

    cat > "$report" << REPORT_HEADER
# 🔍 BugStorm Reconnaissance Report
## Target: $domain
## Date: $(date '+%Y-%m-%d %H:%M:%S %Z')
## Scope: $SCOPE
---

REPORT_HEADER

    # Summary
    cat >> "$report" << SUMMARY
## 📊 Executive Summary

| Metric | Count |
|--------|-------|
| Total Subdomains | $(wc -l < "$OUTDIR/subdomains/all_subdomains.txt" 2>/dev/null || echo 0) |
| Resolved Subdomains | $(wc -l < "$OUTDIR/subdomains/resolved.txt" 2>/dev/null || echo 0) |
| Live Hosts | $(wc -l < "$OUTDIR/subdomains/live_hosts.txt" 2>/dev/null || echo 0) |
| Unique IPs | $(wc -l < "$OUTDIR/subdomains/ips.txt" 2>/dev/null || echo 0) |
| Total URLs | $(wc -l < "$OUTDIR/urls/all_urls.txt" 2>/dev/null || echo 0) |
| JS Files | $(wc -l < "$OUTDIR/urls/js_files.txt" 2>/dev/null || echo 0) |
| API Endpoints | $(wc -l < "$OUTDIR/urls/api_endpoints.txt" 2>/dev/null || echo 0) |
| Parameterized URLs | $(wc -l < "$OUTDIR/urls/parameterized_urls.txt" 2>/dev/null || echo 0) |
| Sensitive Files | $(wc -l < "$OUTDIR/urls/sensitive_files.txt" 2>/dev/null || echo 0) |

---

## 🚨 Vulnerability Summary

| Severity | Count |
|----------|-------|
| Critical | $(wc -l < "$OUTDIR/vulns/nuclei_critical.txt" 2>/dev/null || echo 0) |
| High | $(wc -l < "$OUTDIR/vulns/nuclei_high.txt" 2>/dev/null || echo 0) |
| Medium | $(wc -l < "$OUTDIR/vulns/nuclei_medium.txt" 2>/dev/null || echo 0) |
| Low | $(wc -l < "$OUTDIR/vulns/nuclei_low.txt" 2>/dev/null || echo 0) |
| Info | $(wc -l < "$OUTDIR/vulns/nuclei_info.txt" 2>/dev/null || echo 0) |
| CORS Issues | $(wc -l < "$OUTDIR/vulns/cors_results.txt" 2>/dev/null || echo 0) |
| Open Redirects | $(wc -l < "$OUTDIR/vulns/open_redirects.txt" 2>/dev/null || echo 0) |
| Missing Headers | $(wc -l < "$OUTDIR/vulns/missing_headers.txt" 2>/dev/null || echo 0) |
| Subdomain Takeovers | $(wc -l < "$OUTDIR/vulns/takeover_results.txt" 2>/dev/null || echo 0) |

---

SUMMARY

    # Critical Findings
    cat >> "$report" << 'SECTION'
## 🔴 Critical & High Findings

SECTION

    if [[ -s "$OUTDIR/vulns/nuclei_critical.txt" ]]; then
        echo '```' >> "$report"
        cat "$OUTDIR/vulns/nuclei_critical.txt" >> "$report"
        echo '```' >> "$report"
    fi
    if [[ -s "$OUTDIR/vulns/nuclei_high.txt" ]]; then
        echo '```' >> "$report"
        cat "$OUTDIR/vulns/nuclei_high.txt" >> "$report"
        echo '```' >> "$report"
    fi

    # JS Secrets
    if [[ -s "$OUTDIR/js/secrets.txt" ]]; then
        echo '## 🔑 JavaScript Secrets' >> "$report"
        echo '```' >> "$report"
        cat "$OUTDIR/js/secrets.txt" >> "$report"
        echo '```' >> "$report"
    fi

    # Sensitive Files
    if [[ -s "$OUTDIR/urls/sensitive_files.txt" ]]; then
        echo '## 📁 Sensitive Files Discovered' >> "$report"
        echo '```' >> "$report"
        head -50 "$OUTDIR/urls/sensitive_files.txt" >> "$report"
        echo '```' >> "$report"
    fi

    echo "" >> "$report"
    echo "---" >> "$report"
    echo "*Report generated by BugStorm v${VERSION}*" >> "$report"

    log_success "Report saved: $report"

    # Generate HTML version
    if command -v pandoc &>/dev/null; then
        pandoc "$report" -o "$report_dir/report_${domain}_${TIMESTAMP}.html" \
            --standalone --metadata title="BugStorm Report — $domain" 2>/dev/null || true
        log_success "HTML report generated"
    fi
}

# ════════════════════════════════════════════════════════════════════════
# MAIN ORCHESTRATOR
# ════════════════════════════════════════════════════════════════════════
run_recon() {
    local domain="$1"

    banner
    log_info "Starting BugStorm v${VERSION} recon on: $domain"
    log_info "Scope: $SCOPE | Threads: $THREADS | Rate Limit: $RATE_LIMIT"
    log_info "Timestamp: $TIMESTAMP"

    local start_time
    start_time=$(date +%s)

    # Setup
    setup_output "$domain"
    check_dependencies

    # Run modules
    module_subdomains "$domain"
    module_dns_resolution "$domain"
    module_http_probe "$domain"
    module_port_scan "$domain"
    module_tech_detect "$domain"
    module_url_discovery "$domain"
    module_param_discovery "$domain"
    module_js_analysis "$domain"
    module_dir_bruteforce "$domain"
    module_vuln_scan "$domain"
    module_report "$domain"

    # Completion
    local end_time duration
    end_time=$(date +%s)
    duration=$(( end_time - start_time ))
    local minutes=$(( duration / 60 ))
    local seconds=$(( duration % 60 ))

    log_step "RECON COMPLETE"
    log_success "Target:   $domain"
    log_success "Duration: ${minutes}m ${seconds}s"
    log_success "Results:  $OUTDIR"
    notify "✅ BugStorm [$domain]: Recon complete in ${minutes}m ${seconds}s — Results at $OUTDIR"
}

# ──────────────────────────── MULTI-TARGET ─────────────────────────────
run_multi() {
    local target_file="$1"
    if [[ ! -f "$target_file" ]]; then
        log_error "File not found: $target_file"
        exit 1
    fi

    banner
    log_info "Multi-target mode — processing $(wc -l < "$target_file") domains"

    while IFS= read -r domain; do
        [[ -z "$domain" || "$domain" =~ ^# ]] && continue
        domain=$(echo "$domain" | tr -d '[:space:]')
        log_info "═══ Processing: $domain ═══"
        run_recon "$domain"
    done < "$target_file"
}

# ──────────────────────────── USAGE ────────────────────────────────────
usage() {
    banner
    cat << USAGE
${BOLD}USAGE:${RESET}
    $0 [OPTIONS]

${BOLD}OPTIONS:${RESET}
    -d, --domain <domain>       Target domain (required unless -l used)
    -l, --list <file>           File with list of domains
    -s, --scope <mode>          Scan scope: full|passive|active (default: full)
    -t, --threads <num>         Number of threads (default: 50)
    -r, --rate <num>            Rate limit for port scanning (default: 1000)
    -w, --wordlist <file>       Custom subdomain wordlist
    --resolvers <file>          Custom DNS resolvers file
    --timeout <seconds>         HTTP timeout (default: 10)
    --notify                    Enable notifications
    --discord <webhook>         Discord webhook URL
    --slack <webhook>           Slack webhook URL
    --install                   Install all dependencies
    --check                     Check dependencies only
    -h, --help                  Show this help

${BOLD}EXAMPLES:${RESET}
    $0 -d example.com
    $0 -d example.com -s passive -t 100
    $0 -l targets.txt --notify --discord "https://discord.com/api/webhooks/..."
    $0 -d example.com -s active -r 5000
    $0 --install
    $0 --check

${BOLD}SCOPE MODES:${RESET}
    full    — Run all modules (passive + active) [DEFAULT]
    passive — Only passive recon (no port scan, no brute-force, no dir bust)
    active  — Include active scans (port scanning, brute-force, dir busting)

USAGE
    exit 0
}

# ──────────────────────────── ARG PARSING ──────────────────────────────
main() {
    local domain=""
    local target_list=""

    [[ $# -eq 0 ]] && usage

    while [[ $# -gt 0 ]]; do
        case "$1" in
            -d|--domain)    domain="$2";            shift 2 ;;
            -l|--list)      target_list="$2";       shift 2 ;;
            -s|--scope)     SCOPE="$2";             shift 2 ;;
            -t|--threads)   THREADS="$2";           shift 2 ;;
            -r|--rate)      RATE_LIMIT="$2";        shift 2 ;;
            -w|--wordlist)  WORDLIST="$2";          shift 2 ;;
            --resolvers)    RESOLVERS="$2";         shift 2 ;;
            --timeout)      TIMEOUT="$2";           shift 2 ;;
            --notify)       NOTIFY=true;            shift ;;
            --discord)      DISCORD_WEBHOOK="$2";   shift 2 ;;
            --slack)        SLACK_WEBHOOK="$2";     shift 2 ;;
            --install)      install_dependencies;   exit 0 ;;
            --check)        banner; check_dependencies; exit 0 ;;
            -h|--help)      usage ;;
            *)              log_error "Unknown option: $1"; usage ;;
        esac
    done

    # Validate scope
    case "$SCOPE" in
        full|passive|active) ;;
        *) log_error "Invalid scope: $SCOPE (use: full|passive|active)"; exit 1 ;;
    esac

    # Execute
    if [[ -n "$target_list" ]]; then
        run_multi "$target_list"
    elif [[ -n "$domain" ]]; then
        run_recon "$domain"
    else
        log_error "No target specified. Use -d <domain> or -l <file>"
        exit 1
    fi
}

main "$@"


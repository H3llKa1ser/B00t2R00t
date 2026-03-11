#!/usr/bin/env bash
# ============================================================================
# BugStorm v2.1 — Advanced Bug Bounty Reconnaissance Framework
# ============================================================================
# FIXES in v2.1:
#   1. Module 3 hang/exit: removed global "set -e" / "pipefail" — grep/awk
#      returning exit 1 on no-match was causing script abort via pipefail.
#   2. --install: fixed Go paths, added PATH export, separated Rust/binary
#      tools, added Go presence check.
#   3. --check: now prints ALL missing tools with install instructions.
# ============================================================================

# IMPORTANT: Do NOT use "set -e" or "set -o pipefail" here.
# Many recon tool pipelines return non-zero on empty results (e.g. grep
# finds no matches = exit 1), which kills the script under pipefail/errexit.
set -u
IFS=$'\n\t'

# ──────────────────────────── GLOBAL CONFIG ────────────────────────────────
readonly VERSION="2.1"
readonly BOLD="\e[1m"
readonly RED="\e[31m"
readonly GREEN="\e[32m"
readonly YELLOW="\e[33m"
readonly BLUE="\e[34m"
readonly MAGENTA="\e[35m"
readonly CYAN="\e[36m"
readonly RESET="\e[0m"

THREADS=50
RATE_LIMIT=1000
RESOLVERS="$HOME/bugstorm/wordlists/resolvers.txt"
WORDLIST="$HOME/bugstorm/wordlists/subdomains.txt"
TIMEOUT=10
SCOPE="full"
NOTIFY=false
DISCORD_WEBHOOK=""
SLACK_WEBHOOK=""
TIMESTAMP=$(date +%Y%m%d_%H%M%S)

# Ensure $GOPATH/bin is in PATH (critical for go-installed tools)
export GOPATH="${GOPATH:-$HOME/go}"
export PATH="$GOPATH/bin:$HOME/.local/bin:/usr/local/bin:$PATH"

# ──────────────────────────── BANNER ───────────────────────────────────────
banner() {
    echo -e "${CYAN}"
    cat << 'EOF'
    ____              _____ __
   / __ )__  ______ / ___// /_____  _________ ___
  / __  / / / / __ \\__ \/ __/ __ \/ ___/ __ `__ \
 / /_/ / /_/ / /_/ /__/ / /_/ /_/ / /  / / / / / /
/_____/\__,_/\__, /____/\__/\____/_/  /_/ /_/ /_/
            /____/
         Advanced Recon Framework v2.1
EOF
    echo -e "${RESET}"
}

# ──────────────────────────── LOGGING ──────────────────────────────────────
log_info()    { echo -e "${BLUE}[INFO]${RESET}    $(date '+%H:%M:%S') — $*"; }
log_success() { echo -e "${GREEN}[SUCCESS]${RESET} $(date '+%H:%M:%S') — $*"; }
log_warn()    { echo -e "${YELLOW}[WARN]${RESET}    $(date '+%H:%M:%S') — $*"; }
log_error()   { echo -e "${RED}[ERROR]${RESET}   $(date '+%H:%M:%S') — $*"; }
log_step()    { echo -e "\n${MAGENTA}${BOLD}═══════════════════════════════════════════════${RESET}"; \
                echo -e "${MAGENTA}${BOLD}  ▶  $*${RESET}"; \
                echo -e "${MAGENTA}${BOLD}═══════════════════════════════════════════════${RESET}\n"; }

# ──────────────────────────── NOTIFICATIONS ────────────────────────────────
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

# ════════════════════════════════════════════════════════════════════════════
# DEPENDENCY CHECK (--check)  *** FIXED: prints ALL missing tools ***
# ════════════════════════════════════════════════════════════════════════════
check_dependencies() {
    log_step "Checking Dependencies"

    # Master list: tool_name:category:install_hint
    local tool_entries=(
        "subfinder:Subdomain Enum:go install github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest"
        "amass:Subdomain Enum:go install github.com/owasp-amass/amass/v4/...@master"
        "assetfinder:Subdomain Enum:go install github.com/tomnomnom/assetfinder@latest"
        "findomain:Subdomain Enum:curl -LO https://github.com/findomain/findomain/releases/latest/download/findomain-linux-amd64.zip"
        "httpx:HTTP Probing:go install github.com/projectdiscovery/httpx/cmd/httpx@latest"
        "naabu:Port Scan:go install github.com/projectdiscovery/naabu/v2/cmd/naabu@latest"
        "nuclei:Vuln Scan:go install github.com/projectdiscovery/nuclei/v3/cmd/nuclei@latest"
        "waybackurls:URL Discovery:go install github.com/tomnomnom/waybackurls@latest"
        "gau:URL Discovery:go install github.com/lc/gau/v2/cmd/gau@latest"
        "hakrawler:URL Discovery:go install github.com/hakluke/hakrawler@latest"
        "katana:URL Discovery:go install github.com/projectdiscovery/katana/cmd/katana@latest"
        "ffuf:Dir Busting:go install github.com/ffuf/ffuf/v2@latest"
        "gobuster:Dir Busting:go install github.com/OJ/gobuster/v3@latest"
        "dnsx:DNS:go install github.com/projectdiscovery/dnsx/cmd/dnsx@latest"
        "shuffledns:DNS:go install github.com/projectdiscovery/shuffledns/cmd/shuffledns@latest"
        "nmap:Port Scan:sudo apt install -y nmap || sudo yum install -y nmap"
        "whatweb:Tech Detect:sudo apt install -y whatweb || sudo gem install whatweb"
        "wafw00f:WAF Detect:pip3 install wafw00f"
        "jq:Utility:sudo apt install -y jq || sudo yum install -y jq"
        "curl:Utility:sudo apt install -y curl"
        "openssl:Utility:sudo apt install -y openssl"
        "gf:Params:go install github.com/tomnomnom/gf@latest"
        "qsreplace:Params:go install github.com/tomnomnom/qsreplace@latest"
        "unfurl:Params:go install github.com/tomnomnom/unfurl@latest"
        "anew:Utility:go install github.com/tomnomnom/anew@latest"
    )

    local installed=0
    local missing=0
    local missing_list=()

    for entry in "${tool_entries[@]}"; do
        local tool_name category install_hint
        tool_name=$(echo "$entry" | cut -d: -f1)
        category=$(echo "$entry" | cut -d: -f2)
        install_hint=$(echo "$entry" | cut -d: -f3-)

        if command -v "$tool_name" &>/dev/null; then
            echo -e "  ${GREEN}✔${RESET} ${tool_name} (${category})"
            ((installed++))
        else
            echo -e "  ${RED}✘${RESET} ${tool_name} (${category}) — ${YELLOW}MISSING${RESET}"
            ((missing++))
            missing_list+=("$tool_name|$install_hint")
        fi
    done

    echo ""
    echo -e "${BOLD}────────────────────────────────────────────${RESET}"
    echo -e "${BOLD}  SUMMARY: ${GREEN}${installed} installed${RESET} / ${RED}${missing} missing${RESET}"
    echo -e "${BOLD}────────────────────────────────────────────${RESET}"

    if [[ $missing -gt 0 ]]; then
        echo ""
        echo -e "${YELLOW}${BOLD}  Missing tools and how to install them:${RESET}"
        echo ""
        for item in "${missing_list[@]}"; do
            local name hint
            name=$(echo "$item" | cut -d'|' -f1)
            hint=$(echo "$item" | cut -d'|' -f2-)
            echo -e "    ${RED}✘ ${name}${RESET}"
            echo -e "      ${CYAN}→ ${hint}${RESET}"
            echo ""
        done
        echo -e "${YELLOW}  TIP: Run '$0 --install' to auto-install all tools.${RESET}"
    else
        echo ""
        log_success "All dependencies are installed!"
    fi
}

# ════════════════════════════════════════════════════════════════════════════
# INSTALLER (--install)  *** FIXED: correct paths, Go check, PATH setup ***
# ════════════════════════════════════════════════════════════════════════════
install_dependencies() {
    log_step "Installing Dependencies"

    # ── Step 1: Check for Go ──
    if ! command -v go &>/dev/null; then
        log_error "Go is NOT installed. Many tools require Go ≥ 1.21."
        log_info  "Install Go from: https://go.dev/dl/"
        log_info  "Quick install:"
        log_info  "  wget https://go.dev/dl/go1.22.5.linux-amd64.tar.gz"
        log_info  "  sudo tar -C /usr/local -xzf go1.22.5.linux-amd64.tar.gz"
        log_info  "  echo 'export PATH=\$PATH:/usr/local/go/bin:\$HOME/go/bin' >> ~/.bashrc"
        log_info  "  source ~/.bashrc"
        log_warn  "Skipping Go-based tools. Will install system packages only."
        local HAS_GO=false
    else
        local go_ver
        go_ver=$(go version 2>/dev/null | grep -oP 'go\d+\.\d+' || echo "unknown")
        log_success "Go found: $go_ver"
        local HAS_GO=true

        # Ensure GOPATH/bin exists and is in PATH
        mkdir -p "$GOPATH/bin"
        if ! echo "$PATH" | grep -q "$GOPATH/bin"; then
            export PATH="$GOPATH/bin:$PATH"
            log_info "Added $GOPATH/bin to PATH"
        fi
    fi

    # ── Step 2: Go-based tools ──
    if [[ "$HAS_GO" == true ]]; then
        local go_tools=(
            "subfinder:github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest"
            "httpx:github.com/projectdiscovery/httpx/cmd/httpx@latest"
            "naabu:github.com/projectdiscovery/naabu/v2/cmd/naabu@latest"
            "nuclei:github.com/projectdiscovery/nuclei/v3/cmd/nuclei@latest"
            "dnsx:github.com/projectdiscovery/dnsx/cmd/dnsx@latest"
            "katana:github.com/projectdiscovery/katana/cmd/katana@latest"
            "shuffledns:github.com/projectdiscovery/shuffledns/cmd/shuffledns@latest"
            "waybackurls:github.com/tomnomnom/waybackurls@latest"
            "gf:github.com/tomnomnom/gf@latest"
            "anew:github.com/tomnomnom/anew@latest"
            "unfurl:github.com/tomnomnom/unfurl@latest"
            "qsreplace:github.com/tomnomnom/qsreplace@latest"
            "assetfinder:github.com/tomnomnom/assetfinder@latest"
            "gau:github.com/lc/gau/v2/cmd/gau@latest"
            "hakrawler:github.com/hakluke/hakrawler@latest"
            "ffuf:github.com/ffuf/ffuf/v2@latest"
            "gobuster:github.com/OJ/gobuster/v3@latest"
            "amass:github.com/owasp-amass/amass/v4/...@master"
        )

        for entry in "${go_tools[@]}"; do
            local name pkg
            name=$(echo "$entry" | cut -d: -f1)
            pkg=$(echo "$entry" | cut -d: -f2)

            if command -v "$name" &>/dev/null; then
                echo -e "  ${GREEN}✔${RESET} $name (already installed)"
                continue
            fi

            log_info "Installing $name ..."
            if go install "$pkg" 2>/dev/null; then
                if command -v "$name" &>/dev/null; then
                    echo -e "  ${GREEN}✔${RESET} $name installed successfully"
                else
                    echo -e "  ${YELLOW}⚠${RESET} $name: go install succeeded but binary not in PATH"
                    echo -e "    Check: ls $GOPATH/bin/$name"
                fi
            else
                echo -e "  ${RED}✘${RESET} $name: go install failed"
            fi
        done
    fi

    # ── Step 3: Findomain (Rust binary — direct download) ──
    if ! command -v findomain &>/dev/null; then
        log_info "Installing findomain (binary download)..."
        local fd_url="https://github.com/findomain/findomain/releases/latest/download/findomain-linux-amd64.zip"
        local tmp_dir
        tmp_dir=$(mktemp -d)
        if curl -sL "$fd_url" -o "$tmp_dir/findomain.zip" 2>/dev/null; then
            if unzip -o "$tmp_dir/findomain.zip" -d "$tmp_dir/" &>/dev/null; then
                chmod +x "$tmp_dir/findomain"
                sudo cp "$tmp_dir/findomain" /usr/local/bin/findomain 2>/dev/null \
                    || cp "$tmp_dir/findomain" "$HOME/.local/bin/findomain" 2>/dev/null \
                    || cp "$tmp_dir/findomain" "$GOPATH/bin/findomain" 2>/dev/null
                if command -v findomain &>/dev/null; then
                    echo -e "  ${GREEN}✔${RESET} findomain installed"
                else
                    echo -e "  ${YELLOW}⚠${RESET} findomain downloaded but not in PATH"
                fi
            else
                echo -e "  ${RED}✘${RESET} findomain: unzip failed"
            fi
        else
            echo -e "  ${RED}✘${RESET} findomain: download failed"
        fi
        rm -rf "$tmp_dir"
    else
        echo -e "  ${GREEN}✔${RESET} findomain (already installed)"
    fi

    # ── Step 4: MassDNS (compile from source) ──
    if ! command -v massdns &>/dev/null; then
        log_info "Installing massdns (compile from source)..."
        local tmp_dir
        tmp_dir=$(mktemp -d)
        if git clone --depth 1 https://github.com/blechschmidt/massdns.git "$tmp_dir/massdns" 2>/dev/null; then
            cd "$tmp_dir/massdns" && make -j$(nproc) 2>/dev/null && {
                sudo cp bin/massdns /usr/local/bin/ 2>/dev/null \
                    || cp bin/massdns "$HOME/.local/bin/" 2>/dev/null \
                    || cp bin/massdns "$GOPATH/bin/" 2>/dev/null
            }
            cd - > /dev/null
            if command -v massdns &>/dev/null; then
                echo -e "  ${GREEN}✔${RESET} massdns installed"
            else
                echo -e "  ${YELLOW}⚠${RESET} massdns compiled but not in PATH"
            fi
        else
            echo -e "  ${RED}✘${RESET} massdns: git clone failed"
        fi
        rm -rf "$tmp_dir"
    else
        echo -e "  ${GREEN}✔${RESET} massdns (already installed)"
    fi

    # ── Step 5: System packages ──
    log_info "Installing system packages..."
    local sys_packages="nmap whatweb jq openssl dnsutils"
    if command -v apt-get &>/dev/null; then
        sudo apt-get update -qq 2>/dev/null
        for pkg in $sys_packages; do
            if ! dpkg -l "$pkg" &>/dev/null 2>&1; then
                sudo apt-get install -y -qq "$pkg" 2>/dev/null \
                    && echo -e "  ${GREEN}✔${RESET} $pkg installed" \
                    || echo -e "  ${RED}✘${RESET} $pkg: apt install failed"
            else
                echo -e "  ${GREEN}✔${RESET} $pkg (already installed)"
            fi
        done
    elif command -v yum &>/dev/null; then
        for pkg in nmap jq openssl bind-utils; do
            sudo yum install -y "$pkg" 2>/dev/null \
                && echo -e "  ${GREEN}✔${RESET} $pkg installed" \
                || echo -e "  ${RED}✘${RESET} $pkg: yum install failed"
        done
    else
        log_warn "Neither apt nor yum found. Install system packages manually."
    fi

    # ── Step 6: pip-based tools ──
    if ! command -v wafw00f &>/dev/null; then
        log_info "Installing wafw00f..."
        pip3 install wafw00f 2>/dev/null \
            && echo -e "  ${GREEN}✔${RESET} wafw00f installed" \
            || echo -e "  ${RED}✘${RESET} wafw00f: pip install failed"
    else
        echo -e "  ${GREEN}✔${RESET} wafw00f (already installed)"
    fi

    # ── Step 7: Wordlists ──
    setup_wordlists

    # ── Step 8: GF Patterns ──
    if command -v gf &>/dev/null; then
        log_info "Installing GF patterns..."
        local gf_dir="$HOME/.gf"
        mkdir -p "$gf_dir"
        if [[ ! -f "$gf_dir/xss.json" ]]; then
            git clone --depth 1 https://github.com/1ndianl33t/Gf-Patterns.git /tmp/gf-patterns 2>/dev/null || true
            cp /tmp/gf-patterns/*.json "$gf_dir/" 2>/dev/null || true
            rm -rf /tmp/gf-patterns
            log_success "GF patterns installed"
        else
            log_info "GF patterns already present"
        fi
    fi

    # ── Step 9: Make GOPATH/bin persistent in PATH ──
    log_info "Ensuring GOPATH/bin is in your shell PATH..."
    local shell_rc="$HOME/.bashrc"
    [[ -f "$HOME/.zshrc" ]] && shell_rc="$HOME/.zshrc"
    if ! grep -q 'GOPATH.*bin' "$shell_rc" 2>/dev/null; then
        echo '' >> "$shell_rc"
        echo '# BugStorm: Go binary path' >> "$shell_rc"
        echo 'export GOPATH="${GOPATH:-$HOME/go}"' >> "$shell_rc"
        echo 'export PATH="$GOPATH/bin:$HOME/.local/bin:$PATH"' >> "$shell_rc"
        log_success "Added GOPATH/bin to $shell_rc"
        log_warn "Run 'source $shell_rc' or open a new terminal for changes to take effect."
    fi

    echo ""
    log_step "Installation Complete"
    log_info "Run '$0 --check' to verify all tools are available."
    log_warn "If tools are not found, run: source ~/.bashrc (or ~/.zshrc)"
}

# ──────────────────────────── WORDLISTS ────────────────────────────────────
setup_wordlists() {
    local wl_dir="$HOME/bugstorm/wordlists"
    mkdir -p "$wl_dir"

    if [[ ! -f "$wl_dir/subdomains.txt" ]]; then
        log_info "Downloading subdomain wordlist..."
        curl -sL "https://raw.githubusercontent.com/danielmiessler/SecLists/master/Discovery/DNS/subdomains-top1million-20000.txt" \
            -o "$wl_dir/subdomains.txt" || log_warn "Subdomain wordlist download failed"
    fi

    if [[ ! -f "$wl_dir/resolvers.txt" ]]; then
        log_info "Downloading fresh resolvers..."
        curl -sL "https://raw.githubusercontent.com/trickest/resolvers/main/resolvers-trusted.txt" \
            -o "$wl_dir/resolvers.txt" || log_warn "Resolver list download failed"
    fi

    if [[ ! -f "$wl_dir/dirsearch.txt" ]]; then
        log_info "Downloading directory wordlist..."
        curl -sL "https://raw.githubusercontent.com/danielmiessler/SecLists/master/Discovery/Web-Content/raft-medium-directories.txt" \
            -o "$wl_dir/dirsearch.txt" || log_warn "Directory wordlist download failed"
    fi
}

# ──────────────────────────── OUTPUT SETUP ─────────────────────────────────
setup_output() {
    local domain="$1"
    OUTDIR="$HOME/bugstorm/results/${domain}/${TIMESTAMP}"
    mkdir -p "$OUTDIR"/{subdomains,urls,ports,nuclei,directories,vulns,js,params,tech,reports}
    LOGFILE="$OUTDIR/bugstorm.log"
    exec > >(tee -a "$LOGFILE") 2>&1
    log_info "Output directory: $OUTDIR"
}

# ════════════════════════════════════════════════════════════════════════════
# MODULE 1: SUBDOMAIN ENUMERATION
# ════════════════════════════════════════════════════════════════════════════
module_subdomains() {
    local domain="$1"
    local sub_dir="$OUTDIR/subdomains"
    log_step "MODULE 1: Subdomain Enumeration — $domain"

    # Subfinder
    if command -v subfinder &>/dev/null; then
        log_info "Running subfinder..."
        subfinder -d "$domain" -all -silent -t "$THREADS" \
            -o "$sub_dir/subfinder.txt" 2>/dev/null || true
        log_success "subfinder: $(wc -l < "$sub_dir/subfinder.txt" 2>/dev/null || echo 0) subdomains"
    fi

    # Amass (passive, with timeout to prevent infinite hang)
    if command -v amass &>/dev/null; then
        log_info "Running amass (passive, 10min timeout)..."
        timeout 600 amass enum -passive -d "$domain" \
            -o "$sub_dir/amass.txt" 2>/dev/null || true
        log_success "amass: $(wc -l < "$sub_dir/amass.txt" 2>/dev/null || echo 0) subdomains"
    fi

    # Assetfinder
    if command -v assetfinder &>/dev/null; then
        log_info "Running assetfinder..."
        assetfinder --subs-only "$domain" > "$sub_dir/assetfinder.txt" 2>/dev/null || true
        log_success "assetfinder: $(wc -l < "$sub_dir/assetfinder.txt" 2>/dev/null || echo 0) subdomains"
    fi

    # Findomain
    if command -v findomain &>/dev/null; then
        log_info "Running findomain..."
        findomain -t "$domain" -u "$sub_dir/findomain.txt" --quiet 2>/dev/null || true
        log_success "findomain: $(wc -l < "$sub_dir/findomain.txt" 2>/dev/null || echo 0) subdomains"
    fi

    # crt.sh
    log_info "Querying crt.sh..."
    curl -s "https://crt.sh/?q=%25.$domain&output=json" 2>/dev/null \
        | jq -r '.[].name_value' 2>/dev/null \
        | sed 's/\*\.//g' \
        | sort -u > "$sub_dir/crtsh.txt" || true
    log_success "crt.sh: $(wc -l < "$sub_dir/crtsh.txt" 2>/dev/null || echo 0) subdomains"

    # ShuffleDNS brute-force (active/full only)
    if [[ "$SCOPE" == "full" || "$SCOPE" == "active" ]]; then
        if command -v shuffledns &>/dev/null && [[ -f "$WORDLIST" ]]; then
            log_info "Running shuffledns bruteforce..."
            shuffledns -d "$domain" -w "$WORDLIST" -r "$RESOLVERS" \
                -t "$THREADS" -o "$sub_dir/shuffledns.txt" 2>/dev/null || true
            log_success "shuffledns: $(wc -l < "$sub_dir/shuffledns.txt" 2>/dev/null || echo 0) subdomains"
        fi
    fi

    # Merge & Deduplicate
    log_info "Merging and deduplicating subdomains..."
    cat "$sub_dir"/*.txt 2>/dev/null \
        | grep -E "^[a-zA-Z0-9]" \
        | grep -i "\.${domain}$" \
        | sort -u \
        | tr '[:upper:]' '[:lower:]' \
        > "$sub_dir/all_subdomains.txt" || true

    local total
    total=$(wc -l < "$sub_dir/all_subdomains.txt" 2>/dev/null || echo 0)
    log_success "TOTAL unique subdomains: $total"
    notify "🔍 BugStorm [$domain]: Found $total unique subdomains"
}

# ════════════════════════════════════════════════════════════════════════════
# MODULE 2: DNS RESOLUTION
# ════════════════════════════════════════════════════════════════════════════
module_dns_resolution() {
    local domain="$1"
    local sub_dir="$OUTDIR/subdomains"
    log_step "MODULE 2: DNS Resolution — $domain"

    if command -v dnsx &>/dev/null; then
        log_info "Resolving subdomains with dnsx..."
        dnsx -l "$sub_dir/all_subdomains.txt" -silent -a -resp -t "$THREADS" \
            -o "$sub_dir/resolved_detailed.txt" 2>/dev/null || true

        dnsx -l "$sub_dir/all_subdomains.txt" -silent -t "$THREADS" \
            > "$sub_dir/resolved.txt" 2>/dev/null || true

        # Extract IPs
        grep -oP '\d+\.\d+\.\d+\.\d+' "$sub_dir/resolved_detailed.txt" 2>/dev/null \
            | sort -u > "$sub_dir/ips.txt" || true

        # IP-to-org mapping (first 100 IPs only)
        log_info "Checking IP organizations..."
        while IFS= read -r ip; do
            local org
            org=$(curl -s --max-time 3 "https://ipinfo.io/$ip/org" 2>/dev/null || echo "unknown")
            echo "$ip — $org" >> "$sub_dir/ip_org_mapping.txt"
        done < <(head -100 "$sub_dir/ips.txt" 2>/dev/null) || true

        local resolved_count
        resolved_count=$(wc -l < "$sub_dir/resolved.txt" 2>/dev/null || echo 0)
        log_success "Resolved subdomains: $resolved_count"
        log_success "Unique IPs: $(wc -l < "$sub_dir/ips.txt" 2>/dev/null || echo 0)"
    else
        log_warn "dnsx not found, copying all subdomains as resolved..."
        cp "$sub_dir/all_subdomains.txt" "$sub_dir/resolved.txt" 2>/dev/null || true
    fi
}

# ════════════════════════════════════════════════════════════════════════════
# MODULE 3: HTTP PROBING  *** FIXED: no more hang/crash ***
# ════════════════════════════════════════════════════════════════════════════
# ROOT CAUSE of original hang/exit:
#   1. httpx pipe into grep/awk — grep returns exit 1 if no matches.
#      Under "set -o pipefail", this kills the entire script.
#   2. httpx with unlimited rate can overwhelm and hang on large input.
#
# FIX:
#   - Removed global "set -e" / "set -o pipefail" (see top of script).
#   - Every grep/awk now has "|| true" to prevent non-zero exit.
#   - httpx called with explicit -rl (rate limit) and -timeout.
#   - Input file existence checked before piping.
# ════════════════════════════════════════════════════════════════════════════
module_http_probe() {
    local domain="$1"
    local sub_dir="$OUTDIR/subdomains"
    log_step "MODULE 3: HTTP Probing — $domain"

    # Guard: check input file exists and is non-empty
    if [[ ! -s "$sub_dir/resolved.txt" ]]; then
        log_warn "No resolved subdomains found. Skipping HTTP probing."
        touch "$sub_dir/live_hosts.txt"
        touch "$sub_dir/httpx_full.txt"
        return
    fi

    if command -v httpx &>/dev/null; then
        log_info "Probing live hosts with httpx..."

        # Run httpx with rate limiting and timeout to prevent hanging.
        # -rl 150 = max 150 requests/sec (prevents overwhelming targets)
        # -timeout = per-request timeout
        # Output goes directly to file (no fragile pipe chain)
        httpx -l "$sub_dir/resolved.txt" \
            -silent \
            -t "$THREADS" \
            -rl 150 \
            -timeout "$TIMEOUT" \
            -status-code \
            -content-length \
            -title \
            -tech-detect \
            -follow-redirects \
            -o "$sub_dir/httpx_full.txt" 2>/dev/null || true

        # Extract just URLs — use awk with "|| true" to prevent exit on empty
        awk '{print $1}' "$sub_dir/httpx_full.txt" 2>/dev/null \
            | sort -u > "$sub_dir/live_hosts.txt" || true

        # Categorize by status code (each grep has "|| true")
        grep -E '\[200\]' "$sub_dir/httpx_full.txt" > "$sub_dir/status_200.txt" 2>/dev/null || true
        grep -E '\[301\]|\[302\]|\[303\]|\[307\]|\[308\]' "$sub_dir/httpx_full.txt" > "$sub_dir/status_3xx.txt" 2>/dev/null || true
        grep -E '\[401\]|\[403\]' "$sub_dir/httpx_full.txt" > "$sub_dir/status_auth.txt" 2>/dev/null || true
        grep -E '\[404\]' "$sub_dir/httpx_full.txt" > "$sub_dir/status_404.txt" 2>/dev/null || true
        grep -E '\[500\]|\[502\]|\[503\]' "$sub_dir/httpx_full.txt" > "$sub_dir/status_5xx.txt" 2>/dev/null || true

        local live
        live=$(wc -l < "$sub_dir/live_hosts.txt" 2>/dev/null || echo 0)
        log_success "Live hosts: $live"
        log_info "  200 OK:    $(wc -l < "$sub_dir/status_200.txt" 2>/dev/null || echo 0)"
        log_info "  3xx:       $(wc -l < "$sub_dir/status_3xx.txt" 2>/dev/null || echo 0)"
        log_info "  401/403:   $(wc -l < "$sub_dir/status_auth.txt" 2>/dev/null || echo 0)"
        log_info "  5xx:       $(wc -l < "$sub_dir/status_5xx.txt" 2>/dev/null || echo 0)"
        notify "🌐 BugStorm [$domain]: $live live hosts discovered"
    else
        log_warn "httpx not found. Skipping HTTP probing."
        touch "$sub_dir/live_hosts.txt"
        touch "$sub_dir/httpx_full.txt"
    fi
}

# ════════════════════════════════════════════════════════════════════════════
# MODULE 4: PORT SCANNING
# ════════════════════════════════════════════════════════════════════════════
module_port_scan() {
    local domain="$1"
    local port_dir="$OUTDIR/ports"
    local sub_dir="$OUTDIR/subdomains"
    log_step "MODULE 4: Port Scanning — $domain"

    if [[ "$SCOPE" == "passive" ]]; then
        log_warn "Skipping port scan (passive mode)"
        return
    fi

    # Naabu
    if command -v naabu &>/dev/null && [[ -s "$sub_dir/resolved.txt" ]]; then
        log_info "Running naabu (top 1000 ports)..."
        naabu -l "$sub_dir/resolved.txt" -silent -top-ports 1000 \
            -rate "$RATE_LIMIT" -t "$THREADS" \
            -o "$port_dir/naabu.txt" 2>/dev/null || true
        log_success "naabu: $(wc -l < "$port_dir/naabu.txt" 2>/dev/null || echo 0) open ports"
    fi

    # Nmap (on top IPs)
    if command -v nmap &>/dev/null && [[ -s "$sub_dir/ips.txt" ]]; then
        log_info "Running nmap service detection..."
        head -20 "$sub_dir/ips.txt" \
            | xargs -I{} -P 5 nmap -sV -sC --top-ports 100 -T4 \
                -oN "$port_dir/nmap_{}.txt" {} 2>/dev/null || true
        log_success "nmap scans complete"
    fi
}

# ════════════════════════════════════════════════════════════════════════════
# MODULE 5: TECHNOLOGY DETECTION
# ════════════════════════════════════════════════════════════════════════════
module_tech_detect() {
    local domain="$1"
    local tech_dir="$OUTDIR/tech"
    local sub_dir="$OUTDIR/subdomains"
    log_step "MODULE 5: Technology Detection — $domain"

    # WhatWeb
    if command -v whatweb &>/dev/null && [[ -s "$sub_dir/live_hosts.txt" ]]; then
        log_info "Running whatweb..."
        while IFS= read -r url; do
            whatweb "$url" --color=never -q >> "$tech_dir/whatweb.txt" 2>/dev/null || true
        done < <(head -50 "$sub_dir/live_hosts.txt")
        log_success "whatweb analysis complete"
    fi

    # WAF Detection
    if command -v wafw00f &>/dev/null && [[ -s "$sub_dir/live_hosts.txt" ]]; then
        log_info "Running wafw00f..."
        while IFS= read -r url; do
            wafw00f "$url" >> "$tech_dir/waf_results.txt" 2>/dev/null || true
        done < <(head -30 "$sub_dir/live_hosts.txt")
        log_success "WAF detection complete"
    fi

    # SSL/TLS Analysis
    if [[ -s "$sub_dir/live_hosts.txt" ]]; then
        log_info "Analyzing SSL/TLS configurations..."
        while IFS= read -r subdomain; do
            local host
            host=$(echo "$subdomain" | sed 's|https\?://||' | cut -d'/' -f1)
            echo "=== $host ===" >> "$tech_dir/ssl_analysis.txt"
            echo | timeout 5 openssl s_client -connect "$host:443" -servername "$host" 2>/dev/null \
                | openssl x509 -noout -dates -subject -issuer \
                >> "$tech_dir/ssl_analysis.txt" 2>/dev/null || true
        done < <(head -30 "$sub_dir/live_hosts.txt")
        log_success "SSL/TLS analysis complete"
    fi
}

# ════════════════════════════════════════════════════════════════════════════
# MODULE 6: URL & ENDPOINT DISCOVERY  *** FIXED v2.2 ***
# ════════════════════════════════════════════════════════════════════════════
# ROOT CAUSE of hang:
#   1. waybackurls has NO built-in timeout. The Wayback Machine CDX API
#      rate-limits after ~15-20 rapid requests — throttled connections
#      hang open silently (no error, no EOF), blocking the process forever.
#   2. With hundreds of subdomains in resolved.txt piped via STDIN,
#      waybackurls processes them sequentially. One stalled API response
#      = permanent hang.
#   3. gau and hakrawler have similar risks against archive/crawl APIs.
#
# FIX:
#   - Wrap every URL-discovery tool in `timeout` with a hard kill deadline.
#   - Process subdomains in controlled batches using xargs -P with </dev/null
#     to prevent STDIN fd inheritance issues inside parallel workers.
#   - Add explicit per-tool flags for timeouts and rate limits where supported.
# ════════════════════════════════════════════════════════════════════════════
module_url_discovery() {
    local domain="$1"
    local url_dir="$OUTDIR/urls"
    local sub_dir="$OUTDIR/subdomains"

    log_step "MODULE 6: URL & Endpoint Discovery — $domain"

    # ── Configurable safety limits ──
    local MODULE_TIMEOUT=900         # 15 min hard cap per tool (seconds)
    local PER_DOMAIN_TIMEOUT=120     # 2 min per individual domain lookup
    local MAX_PARALLEL=5             # Concurrent domain lookups
    local MAX_DOMAINS=200            # Cap how many subdomains we query

    # ────────────────────────────────────────────────────────────────────
    # Wayback URLs  *** FIXED ***
    # ────────────────────────────────────────────────────────────────────
    if command -v waybackurls &>/dev/null && [[ -s "$sub_dir/resolved.txt" ]]; then
        log_info "Fetching wayback URLs..."
        log_info "  (timeout: ${MODULE_TIMEOUT}s total, ${PER_DOMAIN_TIMEOUT}s/domain, ${MAX_PARALLEL} parallel)"

        # Process each domain individually with its own timeout.
        # xargs -P for parallelism, </dev/null severs STDIN inheritance,
        # timeout kills any single domain that stalls on the CDX API.
        head -"$MAX_DOMAINS" "$sub_dir/resolved.txt" \
            | timeout "$MODULE_TIMEOUT" xargs -I{} -P "$MAX_PARALLEL" \
                bash -c 'timeout '"$PER_DOMAIN_TIMEOUT"' waybackurls "$1" </dev/null 2>/dev/null' _ {} \
            > "$url_dir/waybackurls.txt" 2>/dev/null || true

        log_success "waybackurls: $(wc -l < "$url_dir/waybackurls.txt" 2>/dev/null || echo 0) URLs"
    fi

    # ────────────────────────────────────────────────────────────────────
    # GAU  *** FIXED (same pattern) ***
    # ────────────────────────────────────────────────────────────────────
    if command -v gau &>/dev/null && [[ -s "$sub_dir/resolved.txt" ]]; then
        log_info "Fetching URLs with gau..."

        # gau supports --timeout natively (in seconds), but it's per-HTTP-request
        # not per-domain. We still need the outer timeout as a hard kill.
        head -"$MAX_DOMAINS" "$sub_dir/resolved.txt" \
            | timeout "$MODULE_TIMEOUT" gau \
                --threads "$MAX_PARALLEL" \
                --timeout "$PER_DOMAIN_TIMEOUT" \
                --retries 2 \
                --blacklist ttf,woff,woff2,eot,png,jpg,jpeg,gif,svg,ico,css \
            > "$url_dir/gau.txt" 2>/dev/null || true

        log_success "gau: $(wc -l < "$url_dir/gau.txt" 2>/dev/null || echo 0) URLs"
    fi

    # ────────────────────────────────────────────────────────────────────
    # Katana (active crawler — already safe with -list flag)
    # ────────────────────────────────────────────────────────────────────
    if command -v katana &>/dev/null && [[ -s "$sub_dir/live_hosts.txt" ]]; then
        log_info "Crawling with katana..."
        timeout "$MODULE_TIMEOUT" katana \
            -list "$sub_dir/live_hosts.txt" \
            -d 3 -jc -kf -silent \
            -t "$THREADS" \
            -rl 100 \
            -timeout "$TIMEOUT" \
            -o "$url_dir/katana.txt" 2>/dev/null || true
        log_success "katana: $(wc -l < "$url_dir/katana.txt" 2>/dev/null || echo 0) URLs"
    fi

    # ────────────────────────────────────────────────────────────────────
    # Hakrawler  *** FIXED ***
    # ────────────────────────────────────────────────────────────────────
    if command -v hakrawler &>/dev/null && [[ -s "$sub_dir/live_hosts.txt" ]]; then
        log_info "Crawling with hakrawler..."

        # hakrawler reads full URLs from STDIN and has a -timeout flag (seconds)
        head -100 "$sub_dir/live_hosts.txt" \
            | timeout "$MODULE_TIMEOUT" hakrawler \
                -d 3 \
                -t "$MAX_PARALLEL" \
                -timeout 10 \
            > "$url_dir/hakrawler.txt" 2>/dev/null || true

        log_success "hakrawler: $(wc -l < "$url_dir/hakrawler.txt" 2>/dev/null || echo 0) URLs"
    fi

    # ────────────────────────────────────────────────────────────────────
    # Merge & Classify
    # ────────────────────────────────────────────────────────────────────
    log_info "Merging and deduplicating all URLs..."
    cat "$url_dir"/waybackurls.txt "$url_dir"/gau.txt \
        "$url_dir"/katana.txt "$url_dir"/hakrawler.txt 2>/dev/null \
        | sort -u > "$url_dir/all_urls.txt" || true

    # Classify URLs (each grep has || true to prevent exit on no-match)
    grep -iE '\.js(\?|$)' "$url_dir/all_urls.txt" \
        > "$url_dir/js_files.txt" 2>/dev/null || true
    grep -iE '\.json(\?|$)' "$url_dir/all_urls.txt" \
        > "$url_dir/json_endpoints.txt" 2>/dev/null || true
    grep -iE '(api|graphql|rest|v[0-9])' "$url_dir/all_urls.txt" \
        > "$url_dir/api_endpoints.txt" 2>/dev/null || true
    grep -iE '\?' "$url_dir/all_urls.txt" \
        > "$url_dir/parameterized_urls.txt" 2>/dev/null || true
    grep -iE '\.(zip|tar|gz|rar|bak|sql|db|log|env|cfg|conf|ini)' \
        "$url_dir/all_urls.txt" \
        > "$url_dir/sensitive_files.txt" 2>/dev/null || true

    local total
    total=$(wc -l < "$url_dir/all_urls.txt" 2>/dev/null || echo 0)
    log_success "TOTAL unique URLs: $total"
    log_success "  JS files:          $(wc -l < "$url_dir/js_files.txt" 2>/dev/null || echo 0)"
    log_success "  API endpoints:     $(wc -l < "$url_dir/api_endpoints.txt" 2>/dev/null || echo 0)"
    log_success "  Parameterized:     $(wc -l < "$url_dir/parameterized_urls.txt" 2>/dev/null || echo 0)"
    log_success "  Sensitive files:   $(wc -l < "$url_dir/sensitive_files.txt" 2>/dev/null || echo 0)"
    notify "🔗 BugStorm [$domain]: $total unique URLs found"
}

# ════════════════════════════════════════════════════════════════════════════
# MODULE 7: PARAMETER DISCOVERY
# ════════════════════════════════════════════════════════════════════════════
module_param_discovery() {
    local domain="$1"
    local param_dir="$OUTDIR/params"
    local url_dir="$OUTDIR/urls"
    log_step "MODULE 7: Parameter Discovery — $domain"

    if command -v unfurl &>/dev/null && [[ -s "$url_dir/parameterized_urls.txt" ]]; then
        log_info "Extracting parameters with unfurl..."
        cat "$url_dir/parameterized_urls.txt" \
            | unfurl keys \
            | sort -u > "$param_dir/discovered_params.txt" 2>/dev/null || true
        log_success "Unique parameters: $(wc -l < "$param_dir/discovered_params.txt" 2>/dev/null || echo 0)"
    fi

    if command -v gf &>/dev/null && [[ -s "$url_dir/parameterized_urls.txt" ]]; then
        log_info "Applying GF patterns..."
        local patterns=(xss ssrf sqli lfi redirect idor rce ssti debug)
        for pattern in "${patterns[@]}"; do
            cat "$url_dir/parameterized_urls.txt" \
                | gf "$pattern" > "$param_dir/gf_${pattern}.txt" 2>/dev/null || true
            local count
            count=$(wc -l < "$param_dir/gf_${pattern}.txt" 2>/dev/null || echo 0)
            [[ "$count" -gt 0 ]] && log_success "  GF $pattern: $count URLs"
        done
    fi
}

# ════════════════════════════════════════════════════════════════════════════
# MODULE 8: JAVASCRIPT ANALYSIS
# ════════════════════════════════════════════════════════════════════════════
module_js_analysis() {
    local domain="$1"
    local js_dir="$OUTDIR/js"
    local url_dir="$OUTDIR/urls"
    log_step "MODULE 8: JavaScript Analysis — $domain"

    if [[ ! -s "$url_dir/js_files.txt" ]]; then
        log_warn "No JS files found, skipping..."
        return
    fi

    # Download JS files
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

    # Extract secrets
    log_info "Scanning JS files for secrets..."
    {
        echo "=== API Keys & Tokens ==="
        grep -rhoP '(api[_-]?key|api[_-]?secret|access[_-]?token|auth[_-]?token|bearer)\s*[:=]\s*['"'"'"][a-zA-Z0-9_\-]{16,}['"'"'"]' "$js_dir/downloaded/" 2>/dev/null || true

        echo ""
        echo "=== AWS Keys ==="
        grep -rhoP '(AKIA[0-9A-Z]{16})' "$js_dir/downloaded/" 2>/dev/null || true

        echo ""
        echo "=== Private Keys ==="
        grep -rhoP '-----BEGIN (RSA |EC |DSA )?PRIVATE KEY-----' "$js_dir/downloaded/" 2>/dev/null || true

        echo ""
        echo "=== Internal URLs ==="
        grep -rhoP 'https?://[a-zA-Z0-9._\-]+\.(internal|local|dev|staging|test)[a-zA-Z0-9./?=&_\-]*' "$js_dir/downloaded/" 2>/dev/null || true

        echo ""
        echo "=== Email Addresses ==="
        grep -rhoP '[a-zA-Z0-9._%+\-]+@[a-zA-Z0-9.\-]+\.[a-zA-Z]{2,}' "$js_dir/downloaded/" 2>/dev/null || true

        echo ""
        echo "=== Hardcoded Passwords ==="
        grep -rhoP '(password|passwd|pwd)\s*[:=]\s*['"'"'"][^'"'"'"]{4,}['"'"'"]' "$js_dir/downloaded/" 2>/dev/null || true

        echo ""
        echo "=== Cloud Storage URLs ==="
        grep -rhoP '(https?://[a-zA-Z0-9_\-]+\.s3\.amazonaws\.com|https?://storage\.googleapis\.com/[a-zA-Z0-9_\-]+)' "$js_dir/downloaded/" 2>/dev/null || true
    } > "$js_dir/secrets.txt"

    # Extract endpoints
    grep -rhoP '["'"'"']/[a-zA-Z0-9_\-/]+["'"'"']' "$js_dir/downloaded/" 2>/dev/null \
        | sed "s/['\"]//g" \
        | sort -u > "$js_dir/endpoints.txt" || true

    log_success "JS Secrets found: $(grep -c '[a-zA-Z]' "$js_dir/secrets.txt" 2>/dev/null || echo 0) lines"
    log_success "JS Endpoints found: $(wc -l < "$js_dir/endpoints.txt" 2>/dev/null || echo 0)"
}

# ════════════════════════════════════════════════════════════════════════════
# MODULE 9: DIRECTORY BRUTEFORCING
# ════════════════════════════════════════════════════════════════════════════
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

    if command -v ffuf &>/dev/null && [[ -s "$sub_dir/live_hosts.txt" ]]; then
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

# ════════════════════════════════════════════════════════════════════════════
# MODULE 10: VULNERABILITY SCANNING
# ════════════════════════════════════════════════════════════════════════════
module_vuln_scan() {
    local domain="$1"
    local vuln_dir="$OUTDIR/vulns"
    local sub_dir="$OUTDIR/subdomains"
    local param_dir="$OUTDIR/params"
    log_step "MODULE 10: Vulnerability Scanning — $domain"

    # Nuclei
    if command -v nuclei &>/dev/null && [[ -s "$sub_dir/live_hosts.txt" ]]; then
        log_info "Updating nuclei templates..."
        nuclei -update-templates -silent 2>/dev/null || true

        log_info "Running nuclei..."
        nuclei -l "$sub_dir/live_hosts.txt" \
            -severity critical,high,medium,low,info \
            -c "$THREADS" -timeout "$TIMEOUT" \
            -o "$OUTDIR/nuclei/nuclei_results.txt" \
            -silent 2>/dev/null || true

        # Categorize (each grep has || true)
        grep -i '\[critical\]' "$OUTDIR/nuclei/nuclei_results.txt" > "$vuln_dir/nuclei_critical.txt" 2>/dev/null || true
        grep -i '\[high\]' "$OUTDIR/nuclei/nuclei_results.txt" > "$vuln_dir/nuclei_high.txt" 2>/dev/null || true
        grep -i '\[medium\]' "$OUTDIR/nuclei/nuclei_results.txt" > "$vuln_dir/nuclei_medium.txt" 2>/dev/null || true
        grep -i '\[low\]' "$OUTDIR/nuclei/nuclei_results.txt" > "$vuln_dir/nuclei_low.txt" 2>/dev/null || true
        grep -i '\[info\]' "$OUTDIR/nuclei/nuclei_results.txt" > "$vuln_dir/nuclei_info.txt" 2>/dev/null || true

        log_success "Nuclei results:"
        log_success "  Critical: $(wc -l < "$vuln_dir/nuclei_critical.txt" 2>/dev/null || echo 0)"
        log_success "  High:     $(wc -l < "$vuln_dir/nuclei_high.txt" 2>/dev/null || echo 0)"
        log_success "  Medium:   $(wc -l < "$vuln_dir/nuclei_medium.txt" 2>/dev/null || echo 0)"
        log_success "  Low:      $(wc -l < "$vuln_dir/nuclei_low.txt" 2>/dev/null || echo 0)"
        log_success "  Info:     $(wc -l < "$vuln_dir/nuclei_info.txt" 2>/dev/null || echo 0)"
    fi

    # Subdomain Takeover
    if command -v nuclei &>/dev/null && [[ -s "$sub_dir/resolved.txt" ]]; then
        log_info "Checking for subdomain takeovers..."
        nuclei -l "$sub_dir/resolved.txt" \
            -t "$HOME/nuclei-templates/http/takeovers/" \
            -c "$THREADS" -silent \
            -o "$vuln_dir/takeover_results.txt" 2>/dev/null || true
        local takeovers
        takeovers=$(wc -l < "$vuln_dir/takeover_results.txt" 2>/dev/null || echo 0)
        [[ "$takeovers" -gt 0 ]] && notify "🚨 BugStorm [$domain]: $takeovers potential subdomain takeovers!"
        log_success "Takeover check: $takeovers findings"
    fi

    # CORS Misconfiguration
    log_info "Checking CORS misconfigurations..."
    touch "$vuln_dir/cors_results.txt"
    while IFS= read -r url; do
        local response
        response=$(curl -sI -H "Origin: https://evil.com" --max-time 5 "$url" 2>/dev/null || true)
        if echo "$response" | grep -qi "access-control-allow-origin: https://evil.com"; then
            echo "[CORS VULN] $url" >> "$vuln_dir/cors_results.txt"
        fi
    done < <(head -50 "$sub_dir/live_hosts.txt" 2>/dev/null) || true
    log_success "CORS check: $(wc -l < "$vuln_dir/cors_results.txt" 2>/dev/null || echo 0) findings"

    # Open Redirect Check
    touch "$vuln_dir/open_redirects.txt"
    if [[ -s "$param_dir/gf_redirect.txt" ]] && command -v qsreplace &>/dev/null; then
        log_info "Checking open redirects..."
        cat "$param_dir/gf_redirect.txt" \
            | qsreplace "https://evil.com" \
            | head -100 \
            | while IFS= read -r url; do
                local location
                location=$(curl -sI -L --max-redirs 3 --max-time 5 "$url" 2>/dev/null | grep -i "^location:" | tail -1 || true)
                if echo "$location" | grep -qi "evil.com"; then
                    echo "[OPEN REDIRECT] $url" >> "$vuln_dir/open_redirects.txt"
                fi
            done || true
        log_success "Open redirect check: $(wc -l < "$vuln_dir/open_redirects.txt" 2>/dev/null || echo 0) findings"
    fi

    # Security Headers
    log_info "Analyzing security headers..."
    touch "$vuln_dir/missing_headers.txt"
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
    done < <(head -50 "$sub_dir/live_hosts.txt" 2>/dev/null) || true
    log_success "Security header check complete"

    notify "🎯 BugStorm [$domain]: Vulnerability scanning complete!"
}

# ════════════════════════════════════════════════════════════════════════════
# MODULE 11: REPORT GENERATION
# ════════════════════════════════════════════════════════════════════════════
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
## Version: $VERSION
---

REPORT_HEADER

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
| CORS Issues | $(wc -l < "$OUTDIR/vulns/cors_results.txt" 2>/dev/null || echo 0) |
| Open Redirects | $(wc -l < "$OUTDIR/vulns/open_redirects.txt" 2>/dev/null || echo 0) |
| Missing Headers | $(wc -l < "$OUTDIR/vulns/missing_headers.txt" 2>/dev/null || echo 0) |
| Subdomain Takeovers | $(wc -l < "$OUTDIR/vulns/takeover_results.txt" 2>/dev/null || echo 0) |

---

SUMMARY

    # Critical findings
    echo '## 🔴 Critical & High Findings' >> "$report"
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

    echo "" >> "$report"
    echo "---" >> "$report"
    echo "*Report generated by BugStorm v${VERSION}*" >> "$report"

    log_success "Report saved: $report"

    # HTML version
    if command -v pandoc &>/dev/null; then
        pandoc "$report" -o "$report_dir/report_${domain}_${TIMESTAMP}.html" \
            --standalone --metadata title="BugStorm Report — $domain" 2>/dev/null || true
        log_success "HTML report generated"
    fi
}

# ════════════════════════════════════════════════════════════════════════════
# MAIN ORCHESTRATOR
# ════════════════════════════════════════════════════════════════════════════
run_recon() {
    local domain="$1"

    banner
    log_info "Starting BugStorm v${VERSION} recon on: $domain"
    log_info "Scope: $SCOPE | Threads: $THREADS | Rate Limit: $RATE_LIMIT"
    log_info "Timestamp: $TIMESTAMP"

    local start_time
    start_time=$(date +%s)

    setup_output "$domain"
    check_dependencies

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

    local end_time duration
    end_time=$(date +%s)
    duration=$(( end_time - start_time ))
    local minutes=$(( duration / 60 ))
    local seconds=$(( duration % 60 ))

    log_step "RECON COMPLETE"
    log_success "Target:   $domain"
    log_success "Duration: ${minutes}m ${seconds}s"
    log_success "Results:  $OUTDIR"
    notify "✅ BugStorm [$domain]: Recon complete in ${minutes}m ${seconds}s"
}

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

# ──────────────────────────── USAGE ────────────────────────────────────────
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
    --check                     Check ALL dependencies and show missing
    -h, --help                  Show this help

${BOLD}EXAMPLES:${RESET}
    $0 -d example.com
    $0 -d example.com -s passive -t 100
    $0 -l targets.txt --notify --discord "https://discord.com/api/webhooks/..."
    $0 --install
    $0 --check

USAGE
    exit 0
}

# ──────────────────────────── ARG PARSING ──────────────────────────────────
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

    case "$SCOPE" in
        full|passive|active) ;;
        *) log_error "Invalid scope: $SCOPE (use: full|passive|active)"; exit 1 ;;
    esac

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


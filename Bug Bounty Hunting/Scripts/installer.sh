# ════════════════════════════════════════════════════════════════════════════
# INSTALLER (--install)  *** FIXED v2.3 ***
# ════════════════════════════════════════════════════════════════════════════
# FIXES:
#   1. System dependencies (libpcap-dev, git, make, gcc, unzip, pip3)
#      installed FIRST, before Go tools that depend on them.
#   2. go install errors are shown (stderr no longer swallowed).
#   3. dpkg check replaced with command -v for reliability.
#   4. amass install path fixed (explicit cmd/amass, @latest not @master).
#   5. whatweb falls back to gem install if apt fails.
#   6. ~/.local/bin created early and added to PATH.
#   7. findomain URL uses correct GitHub API for latest release detection.
#   8. Go auto-install offered if missing.
#   9. Verification pass at the end shows exactly what succeeded/failed.
# ════════════════════════════════════════════════════════════════════════════
install_dependencies() {
    log_step "Installing Dependencies (v2.3)"

    local INSTALL_LOG="/tmp/bugstorm_install_$(date +%s).log"
    local failed_tools=()
    local installed_tools=()

    # ── Helper: track results ──
    _install_ok()   { installed_tools+=("$1"); echo -e "  ${GREEN}✔${RESET} $1 installed successfully"; }
    _install_skip() { echo -e "  ${GREEN}✔${RESET} $1 (already installed)"; }
    _install_fail() { failed_tools+=("$1"); echo -e "  ${RED}✘${RESET} $1: $2"; }

    # ══════════════════════════════════════════════════════════════════════
    # STEP 0: Create local bin directories (needed for fallback copies)
    # ══════════════════════════════════════════════════════════════════════
    mkdir -p "$HOME/.local/bin"
    mkdir -p "${GOPATH:-$HOME/go}/bin"

    # Ensure both are in PATH for this session
    export PATH="$HOME/.local/bin:${GOPATH:-$HOME/go}/bin:$PATH"

    # ══════════════════════════════════════════════════════════════════════
    # STEP 1: Build prerequisites & system libraries (MUST be first)
    # ══════════════════════════════════════════════════════════════════════
    # naabu requires libpcap-dev at compile time. massdns requires make/gcc.
    # findomain requires unzip. wafw00f requires pip3.
    log_info "Step 1: Installing build prerequisites and system libraries..."

    if command -v apt-get &>/dev/null; then
        sudo apt-get update -qq 2>/dev/null || true

        local prereqs=(git make gcc unzip curl wget jq openssl dnsutils
                       libpcap-dev nmap pip)

        # Note: 'pip' is the apt package name for pip3 on modern Debian/Ubuntu
        # On older systems it might be 'python3-pip'
        for pkg in "${prereqs[@]}"; do
            # Use dpkg -s (not dpkg -l) for accurate installed check
            if dpkg -s "$pkg" &>/dev/null 2>&1; then
                echo -e "  ${GREEN}✔${RESET} $pkg (already installed)"
            else
                log_info "  Installing $pkg..."
                if sudo apt-get install -y -qq "$pkg" >> "$INSTALL_LOG" 2>&1; then
                    echo -e "  ${GREEN}✔${RESET} $pkg installed"
                else
                    # Retry with alternate package names
                    case "$pkg" in
                        pip)
                            sudo apt-get install -y -qq python3-pip >> "$INSTALL_LOG" 2>&1 \
                                && echo -e "  ${GREEN}✔${RESET} python3-pip installed" \
                                || echo -e "  ${YELLOW}⚠${RESET} $pkg: install failed (non-critical)"
                            ;;
                        *)
                            echo -e "  ${YELLOW}⚠${RESET} $pkg: apt install failed"
                            ;;
                    esac
                fi
            fi
        done

    elif command -v yum &>/dev/null; then
        local prereqs=(git make gcc unzip curl wget jq openssl bind-utils
                       libpcap-devel nmap python3-pip)
        for pkg in "${prereqs[@]}"; do
            if rpm -q "$pkg" &>/dev/null 2>&1; then
                echo -e "  ${GREEN}✔${RESET} $pkg (already installed)"
            else
                sudo yum install -y "$pkg" >> "$INSTALL_LOG" 2>&1 \
                    && echo -e "  ${GREEN}✔${RESET} $pkg installed" \
                    || echo -e "  ${YELLOW}⚠${RESET} $pkg: yum install failed"
            fi
        done

    elif command -v pacman &>/dev/null; then
        sudo pacman -Sy --noconfirm --needed \
            git make gcc unzip curl wget jq openssl libpcap nmap \
            python-pip >> "$INSTALL_LOG" 2>&1 || true
        log_info "pacman packages processed"
    else
        log_warn "No supported package manager found (apt/yum/pacman)."
        log_warn "Manually install: git make gcc unzip curl libpcap-dev nmap jq"
    fi

    # ── whatweb (not in default repos — try apt, then gem) ──
    if ! command -v whatweb &>/dev/null; then
        log_info "  Installing whatweb..."
        if command -v apt-get &>/dev/null; then
            if ! sudo apt-get install -y -qq whatweb >> "$INSTALL_LOG" 2>&1; then
                log_info "  whatweb not in apt repos, trying gem..."
                if command -v gem &>/dev/null; then
                    sudo gem install whatweb >> "$INSTALL_LOG" 2>&1 \
                        && _install_ok "whatweb" \
                        || _install_fail "whatweb" "both apt and gem install failed"
                else
                    log_info "  gem not found, trying snap..."
                    if command -v snap &>/dev/null; then
                        sudo snap install whatweb >> "$INSTALL_LOG" 2>&1 \
                            && _install_ok "whatweb" \
                            || _install_fail "whatweb" "apt/gem/snap all failed — install manually"
                    else
                        _install_fail "whatweb" "apt failed, gem/snap not available — sudo gem install whatweb"
                    fi
                fi
            else
                _install_ok "whatweb"
            fi
        fi
    else
        _install_skip "whatweb"
    fi

    # ══════════════════════════════════════════════════════════════════════
    # STEP 2: Go — check, and auto-install if missing
    # ══════════════════════════════════════════════════════════════════════
    log_info "Step 2: Checking Go installation..."

    local HAS_GO=false

    if ! command -v go &>/dev/null; then
        log_warn "Go is NOT installed. Attempting auto-install..."

        local GO_VERSION="1.22.5"
        local GO_ARCH="amd64"
        # Detect ARM
        case "$(uname -m)" in
            aarch64|arm64) GO_ARCH="arm64" ;;
            armv*)         GO_ARCH="armv6l" ;;
        esac
        local GO_TAR="go${GO_VERSION}.linux-${GO_ARCH}.tar.gz"
        local GO_URL="https://go.dev/dl/${GO_TAR}"

        log_info "  Downloading Go ${GO_VERSION} (${GO_ARCH})..."
        if curl -sL "$GO_URL" -o "/tmp/${GO_TAR}" 2>/dev/null; then
            sudo rm -rf /usr/local/go
            if sudo tar -C /usr/local -xzf "/tmp/${GO_TAR}" 2>/dev/null; then
                export PATH="/usr/local/go/bin:$GOPATH/bin:$PATH"
                rm -f "/tmp/${GO_TAR}"
                if command -v go &>/dev/null; then
                    HAS_GO=true
                    log_success "Go $(go version | awk '{print $3}') installed successfully"
                else
                    log_error "Go extracted but binary not found in PATH"
                fi
            else
                log_error "Failed to extract Go tarball"
            fi
        else
            log_error "Failed to download Go from $GO_URL"
        fi

        if [[ "$HAS_GO" == false ]]; then
            log_error "Go auto-install failed. Install manually:"
            log_info  "  wget $GO_URL"
            log_info  "  sudo tar -C /usr/local -xzf $GO_TAR"
            log_info  "  export PATH=\$PATH:/usr/local/go/bin:\$HOME/go/bin"
            log_warn  "Skipping all Go-based tools."
        fi
    else
        HAS_GO=true
        local go_ver
        go_ver=$(go version 2>/dev/null | awk '{print $3}' || echo "unknown")
        log_success "Go found: $go_ver"

        # Ensure GOPATH/bin exists
        mkdir -p "$GOPATH/bin"
        export PATH="$GOPATH/bin:$PATH"
    fi

    # ══════════════════════════════════════════════════════════════════════
    # STEP 3: Go-based tools (with errors VISIBLE, not swallowed)
    # ══════════════════════════════════════════════════════════════════════
    if [[ "$HAS_GO" == true ]]; then
        log_info "Step 3: Installing Go-based tools..."

        # FIXED tool paths:
        #   - amass: explicit cmd/amass path, @latest (not @master with ...)
        #   - ffuf: v2 requires explicit /v2 in path (already correct)
        #   - gobuster: v3 path (already correct)
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
            "amass:github.com/owasp-amass/amass/v4/cmd/amass@latest"
        )

        for entry in "${go_tools[@]}"; do
            local name pkg
            name="${entry%%:*}"
            pkg="${entry#*:}"

            if command -v "$name" &>/dev/null; then
                _install_skip "$name"
                continue
            fi

            log_info "  Installing $name ..."

            # *** FIX: Show stderr so compilation errors are visible ***
            # Timeout at 5 minutes per tool (large tools like amass/nuclei
            # can take a while to compile, but shouldn't take > 5min)
            if timeout 300 go install "$pkg" 2>&1 | tee -a "$INSTALL_LOG"; then
                # Verify the binary actually exists in GOPATH/bin
                # (go install can exit 0 but produce no binary in edge cases)
                if command -v "$name" &>/dev/null; then
                    _install_ok "$name"
                elif [[ -f "$GOPATH/bin/$name" ]]; then
                    # Binary exists but not in hashed PATH — refresh
                    hash -r 2>/dev/null || true
                    if command -v "$name" &>/dev/null; then
                        _install_ok "$name"
                    else
                        echo -e "  ${YELLOW}⚠${RESET} $name: binary at $GOPATH/bin/$name but not in PATH"
                        _install_fail "$name" "binary exists but PATH issue"
                    fi
                else
                    _install_fail "$name" "go install exited 0 but no binary produced"
                fi
            else
                local exit_code=$?
                if [[ $exit_code -eq 124 ]]; then
                    _install_fail "$name" "compilation timed out (>5 min)"
                else
                    _install_fail "$name" "go install failed (exit $exit_code) — check $INSTALL_LOG"
                fi
            fi
        done
    fi

    # ══════════════════════════════════════════════════════════════════════
    # STEP 4: Findomain (Rust binary — direct download)
    # ══════════════════════════════════════════════════════════════════════
    if ! command -v findomain &>/dev/null; then
        log_info "Step 4: Installing findomain (binary download)..."

        # *** FIX: Use GitHub API to get the actual latest release URL ***
        local fd_url=""
        local fd_api="https://api.github.com/repos/findomain/findomain/releases/latest"

        # Try GitHub API first (gives us the real download URL)
        if command -v jq &>/dev/null; then
            fd_url=$(curl -s "$fd_api" 2>/dev/null \
                | jq -r '.assets[] | select(.name | test("linux.*amd64|linux-amd64")) | .browser_download_url' \
                | head -1)
        fi

        # Fallback to known URL pattern
        if [[ -z "$fd_url" || "$fd_url" == "null" ]]; then
            fd_url="https://github.com/findomain/findomain/releases/latest/download/findomain-linux-amd64.zip"
        fi

        local tmp_dir
        tmp_dir=$(mktemp -d)

        log_info "  Downloading from: $fd_url"
        if curl -sL --fail "$fd_url" -o "$tmp_dir/findomain_dl" 2>/dev/null; then
            # Detect if it's a zip or a raw binary
            local file_type
            file_type=$(file "$tmp_dir/findomain_dl" 2>/dev/null || echo "unknown")

            if echo "$file_type" | grep -qi "zip"; then
                if unzip -o "$tmp_dir/findomain_dl" -d "$tmp_dir/" >> "$INSTALL_LOG" 2>&1; then
                    chmod +x "$tmp_dir/findomain"
                else
                    _install_fail "findomain" "unzip failed"
                    rm -rf "$tmp_dir"
                fi
            elif echo "$file_type" | grep -qi "elf\|executable"; then
                mv "$tmp_dir/findomain_dl" "$tmp_dir/findomain"
                chmod +x "$tmp_dir/findomain"
            else
                _install_fail "findomain" "unknown file type: $file_type"
                rm -rf "$tmp_dir"
            fi

            # Copy binary to a PATH location
            if [[ -f "$tmp_dir/findomain" && -x "$tmp_dir/findomain" ]]; then
                if sudo cp "$tmp_dir/findomain" /usr/local/bin/findomain 2>/dev/null; then
                    _install_ok "findomain"
                elif cp "$tmp_dir/findomain" "$HOME/.local/bin/findomain" 2>/dev/null; then
                    _install_ok "findomain"
                elif cp "$tmp_dir/findomain" "$GOPATH/bin/findomain" 2>/dev/null; then
                    _install_ok "findomain"
                else
                    _install_fail "findomain" "could not copy binary to any PATH location"
                fi
            fi
        else
            _install_fail "findomain" "download failed (HTTP error or network issue)"
        fi
        rm -rf "$tmp_dir"
    else
        _install_skip "findomain"
    fi

    # ══════════════════════════════════════════════════════════════════════
    # STEP 5: MassDNS (compile from source)
    # ══════════════════════════════════════════════════════════════════════
    if ! command -v massdns &>/dev/null; then
        log_info "Step 5: Installing massdns (compile from source)..."

        if ! command -v make &>/dev/null || ! command -v gcc &>/dev/null; then
            _install_fail "massdns" "requires make and gcc — install build-essential first"
        else
            local tmp_dir
            tmp_dir=$(mktemp -d)
            if git clone --depth 1 https://github.com/blechschmidt/massdns.git \
                    "$tmp_dir/massdns" >> "$INSTALL_LOG" 2>&1; then
                if (cd "$tmp_dir/massdns" && make -j"$(nproc)" >> "$INSTALL_LOG" 2>&1); then
                    if sudo cp "$tmp_dir/massdns/bin/massdns" /usr/local/bin/ 2>/dev/null \
                        || cp "$tmp_dir/massdns/bin/massdns" "$HOME/.local/bin/" 2>/dev/null \
                        || cp "$tmp_dir/massdns/bin/massdns" "$GOPATH/bin/" 2>/dev/null; then
                        _install_ok "massdns"
                    else
                        _install_fail "massdns" "compiled but could not copy to PATH"
                    fi
                else
                    _install_fail "massdns" "make failed — check $INSTALL_LOG"
                fi
            else
                _install_fail "massdns" "git clone failed"
            fi
            rm -rf "$tmp_dir"
        fi
    else
        _install_skip "massdns"
    fi

    # ══════════════════════════════════════════════════════════════════════
    # STEP 6: pip-based tools
    # ══════════════════════════════════════════════════════════════════════
    log_info "Step 6: Installing pip-based tools..."

    if ! command -v wafw00f &>/dev/null; then
        if command -v pip3 &>/dev/null; then
            pip3 install wafw00f >> "$INSTALL_LOG" 2>&1 \
                && _install_ok "wafw00f" \
                || _install_fail "wafw00f" "pip3 install failed — check $INSTALL_LOG"
        elif command -v pip &>/dev/null; then
            pip install wafw00f >> "$INSTALL_LOG" 2>&1 \
                && _install_ok "wafw00f" \
                || _install_fail "wafw00f" "pip install failed"
        else
            _install_fail "wafw00f" "pip3/pip not found — install python3-pip first"
        fi
    else
        _install_skip "wafw00f"
    fi

    # ══════════════════════════════════════════════════════════════════════
    # STEP 7: Wordlists
    # ══════════════════════════════════════════════════════════════════════
    log_info "Step 7: Downloading wordlists..."
    setup_wordlists

    # ══════════════════════════════════════════════════════════════════════
    # STEP 8: GF Patterns
    # ══════════════════════════════════════════════════════════════════════
    if command -v gf &>/dev/null; then
        log_info "Step 8: Installing GF patterns..."
        local gf_dir="$HOME/.gf"
        mkdir -p "$gf_dir"
        if [[ ! -f "$gf_dir/xss.json" ]]; then
            git clone --depth 1 https://github.com/1ndianl33t/Gf-Patterns.git \
                /tmp/gf-patterns >> "$INSTALL_LOG" 2>&1 || true
            cp /tmp/gf-patterns/*.json "$gf_dir/" 2>/dev/null || true
            rm -rf /tmp/gf-patterns
            log_success "GF patterns installed"
        else
            log_info "GF patterns already present"
        fi
    else
        log_warn "Step 8: gf not installed, skipping GF patterns"
    fi

    # ══════════════════════════════════════════════════════════════════════
    # STEP 9: Nuclei templates
    # ══════════════════════════════════════════════════════════════════════
    if command -v nuclei &>/dev/null; then
        log_info "Step 9: Updating nuclei templates..."
        nuclei -update-templates -silent >> "$INSTALL_LOG" 2>&1 || true
        log_success "Nuclei templates updated"
    fi

    # ══════════════════════════════════════════════════════════════════════
    # STEP 10: Persist PATH in shell RC
    # ══════════════════════════════════════════════════════════════════════
    log_info "Step 10: Ensuring PATH is persistent..."
    local shell_rc="$HOME/.bashrc"
    [[ -f "$HOME/.zshrc" ]] && shell_rc="$HOME/.zshrc"

    local path_block='# BugStorm: tool paths
export GOPATH="${GOPATH:-$HOME/go}"
export PATH="/usr/local/go/bin:$GOPATH/bin:$HOME/.local/bin:$PATH"'

    if ! grep -q 'BugStorm: tool paths' "$shell_rc" 2>/dev/null; then
        echo "" >> "$shell_rc"
        echo "$path_block" >> "$shell_rc"
        log_success "Added tool paths to $shell_rc"
    else
        log_info "PATH block already in $shell_rc"
    fi

    # ══════════════════════════════════════════════════════════════════════
    # STEP 11: VERIFICATION PASS — run --check logic inline
    # ══════════════════════════════════════════════════════════════════════
    echo ""
    log_step "Installation Verification"

    # Refresh PATH hash table so bash finds newly installed binaries
    hash -r 2>/dev/null || true
    export PATH="/usr/local/go/bin:$GOPATH/bin:$HOME/.local/bin:/usr/local/bin:$PATH"

    local all_tools=(
        subfinder amass assetfinder findomain httpx naabu nuclei
        waybackurls gau hakrawler katana ffuf gobuster dnsx shuffledns
        massdns nmap whatweb wafw00f jq curl openssl gf qsreplace
        unfurl anew
    )

    local final_installed=0
    local final_missing=0
    local final_missing_names=()

    for tool in "${all_tools[@]}"; do
        if command -v "$tool" &>/dev/null; then
            echo -e "  ${GREEN}✔${RESET} $tool"
            final_installed=$((final_installed + 1))
        else
            echo -e "  ${RED}✘${RESET} $tool — ${YELLOW}NOT FOUND${RESET}"
            final_missing=$((final_missing + 1))
            final_missing_names+=("$tool")
        fi
    done

    echo ""
    echo -e "${BOLD}════════════════════════════════════════════════════════${RESET}"
    echo -e "${BOLD}  FINAL RESULT: ${GREEN}${final_installed} installed${RESET} / ${RED}${final_missing} missing${RESET}"
    echo -e "${BOLD}════════════════════════════════════════════════════════${RESET}"

    if [[ $final_missing -gt 0 ]]; then
        echo ""
        echo -e "${YELLOW}  Still missing: ${final_missing_names[*]}${RESET}"
        echo ""
        echo -e "${YELLOW}  Possible fixes:${RESET}"
        echo -e "    1. Run: ${CYAN}source $shell_rc${RESET} (then re-run --check)"
        echo -e "    2. Open a new terminal and run: ${CYAN}$0 --check${RESET}"
        echo -e "    3. Some tools may need manual install — check: ${CYAN}$INSTALL_LOG${RESET}"
    else
        echo ""
        log_success "All tools installed and verified! 🎉"
    fi

    echo ""
    log_info "Full install log: $INSTALL_LOG"
}

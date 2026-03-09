#!/usr/bin/env bash
# ============================================================================
# BugStorm Quick Module Runner
# Run individual recon modules independently
# ============================================================================

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/bugstorm.sh" 2>/dev/null || true

usage() {
    cat << EOF
BugStorm Quick Module Runner

Usage: $0 -d <domain> -m <module>

Modules:
    subs        Subdomain enumeration only
    dns         DNS resolution only
    probe       HTTP probing only
    ports       Port scanning only
    tech        Technology detection only
    urls        URL discovery only
    params      Parameter discovery only
    js          JavaScript analysis only
    dirs        Directory bruteforcing only
    vulns       Vulnerability scanning only
    report      Generate report from existing data

Examples:
    $0 -d example.com -m subs
    $0 -d example.com -m vulns
    $0 -d example.com -m report
EOF
    exit 0
}

[[ $# -eq 0 ]] && usage

DOMAIN=""
MODULE=""

while [[ $# -gt 0 ]]; do
    case "$1" in
        -d) DOMAIN="$2"; shift 2 ;;
        -m) MODULE="$2"; shift 2 ;;
        -h) usage ;;
        *)  shift ;;
    esac
done

[[ -z "$DOMAIN" || -z "$MODULE" ]] && usage

# Find latest output dir or create new one
LATEST_DIR=$(ls -td "$HOME/bugstorm/results/${DOMAIN}"/*/ 2>/dev/null | head -1 || true)
if [[ -z "$LATEST_DIR" ]]; then
    setup_output "$DOMAIN"
else
    OUTDIR="${LATEST_DIR%/}"
    log_info "Using existing output: $OUTDIR"
fi

case "$MODULE" in
    subs)   module_subdomains "$DOMAIN" ;;
    dns)    module_dns_resolution "$DOMAIN" ;;
    probe)  module_http_probe "$DOMAIN" ;;
    ports)  module_port_scan "$DOMAIN" ;;
    tech)   module_tech_detect "$DOMAIN" ;;
    urls)   module_url_discovery "$DOMAIN" ;;
    params) module_param_discovery "$DOMAIN" ;;
    js)     module_js_analysis "$DOMAIN" ;;
    dirs)   module_dir_bruteforce "$DOMAIN" ;;
    vulns)  module_vuln_scan "$DOMAIN" ;;
    report) module_report "$DOMAIN" ;;
    *)      log_error "Unknown module: $MODULE"; usage ;;
esac


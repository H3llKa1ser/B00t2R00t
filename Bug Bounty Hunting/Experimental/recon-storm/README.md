## THIS TOOL WAS CREATED WITH THE ASSISTANCE OF CLAUDE OPUS 4.6

### Architecture

    recon-storm/
    ├── go.mod
    ├── go.sum
    ├── main.go                    # Entry point, signal handling, crash recovery
    ├── pkg/
    │   ├── config/
    │   │   └── config.go          # Configuration management
    │   ├── installer/
    │   │   └── installer.go       # Auto-installs all required tools
    │   ├── logger/
    │   │   └── logger.go          # Structured logging
    │   ├── state/
    │   │   └── state.go           # Persistent state for crash recovery
    │   ├── scanner/
    │   │   ├── scanner.go         # Scanner orchestrator
    │   │   ├── subdomain.go       # Subdomain enumeration
    │   │   ├── port.go            # Port scanning
    │   │   ├── web.go             # Web probing & tech detection
    │   │   ├── dns.go             # DNS resolution & zone transfers
    │   │   ├── vuln.go            # Vulnerability scanning
    │   │   ├── endpoints.go       # URL/endpoint discovery
    │   │   ├── secrets.go         # Secret/sensitive file discovery
    │   │   └── screenshots.go     # Visual recon
    │   └── reporter/
    │       └── reporter.go        # HTML/JSON/Markdown report generation
    ├── templates/
    │   └── report.html            # HTML report template
    └── wordlists/
        └── README.md              # Wordlist instructions

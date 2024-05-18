# Ligolo-ng 

## Github repo: https://github.com/nicocha30/ligolo-ng

## Precompiled Binaries: https://github.com/nicocha30/ligolo-ng/releases

# Build

- go build -o agent cmd/agent/main.go

- go build -o proxy cmd/proxy/main.go

- Build for Windows

- GOOS=windows go build -o agent.exe cmd/agent/main.go

- GOOS=windows go build -o proxy.exe cmd/proxy/main.go

# Setup

## Linux

- sudo ip tuntap add user YOUR_USERNAME mode tun ligolo

- sudo ip link set ligolo up

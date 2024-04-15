# Daemon Mode

### Starting in v1.0.0 Sliver supports running in "daemon mode," which automatically starts a client listener (but not an interactive console). In order to connect to a server running in daemon mode you'll need to use multiplayer mode.

### There are two ways to start the server in daemon mode:

#### 1) Using the command line interface: sliver-server daemon

#### 2) Set daemon_mode to true in the configs/server.json located in SLIVER_ROOT_DIR (by default: ~/.sliver/configs/server.json). The listener can be configured via the daemon object. The process will respond gracefully to SIGTERM on Unix-like operating systems.

### With this config you can easily setup a systemd service or init script.

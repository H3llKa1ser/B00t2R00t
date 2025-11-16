# Kill Processes 

## Linux

### 1) Search for the aforementioned process that uses a specific port

    sudo lsof -i :8000 || true

### 2) Kill Process

    sudo kill PID

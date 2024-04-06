# Beacon Options

### You may configure Beacon’s defaults through the profile file. There are two types of options: global and local options. The global options change a global Beacon setting. Local options are transaction specific. You must set local options in the right context. Use the set statement to set an option.

#### Example: set "sleeptime" "1000";

### Here are a few options:

## Option --> Context --> Default Value --> Changes

#### 1) data_jitter --> --> 0 --> Append random-length string (up to data_jitter value) to http-get and http-post server output.

#### 2) headers_remove --> --> --> Comma-separated list of HTTP client headers to remove from Beacon C2

#### 3) host_stage --> --> true --> Host payload for staging over HTTP, HTTPS, or DNS. Required by stagers.

#### 4) jitter --> --> 0 --> Default jitter factor (0-99%) This property cannot be used when the sleep option is included in the profile.

#### 5) pipename --> --> msagent_## --> Default name of pipe to use for SMB Beacon’s peer-to- peer communication. Each # is replaced with a random hex value.

#### 6) pipename_stager --> --> status_## --> Name of pipe to use for SMB Beacon’s named pipe stager. Each # is replaced with a random hex value.

#### 7) sample_name --> --> My Profile --> The name of this profile (used in the Indicators of Compromise report)

#### 8) sleep --> --> --> Default sleep time defined as either: seconds jitter (e.g. '20 25') or [n]d [n]h [n]m [n]s [n]j (e.g. '1d 13h 34m 45s 25j') This property cannot be used when the sleeptime and jitter options are included in the profile.

#### 9) sleeptime --> --> 60000 --> Default sleep time (in milliseconds). This property cannot be used when the sleep option is included in the profile.

#### 10) smb_frame_header --> --> --> Prepend header to SMB Beacon messages

#### 11) ssh_banner --> --> Cobalt Strike 4.2 --> SSH Client banner

#### 12) ssh_pipename --> --> postex_ssh_#### --> Name of pipe for SSH sessions. Each # is replaced with a random hex value.

#### 13) steal_token_access_mask --> --> Blank/0 (TOKEN_ALL_ACCESS) --> Sets the default used by steal_token beacon command and bsteal_token beacon aggressor script command for the OpenProcessToken functions "Desired Access". Suggestion: use "11"for "TOKEN_DUPLICATE | TOKEN_ASSIGN_PRIMARY | TOKEN_QUERY"

#### 14) tasks_max_size --> --> 1048576 --> The maximum size (in bytes) of task(s) and proxy data that can be transferred through a communication channel at a check in

#### 15) tasks_proxy_max_size --> --> 921600 --> The maximum size (in bytes) of proxy data to transfer via the communication channel at a check in.

#### 16) tasks_dns_proxy_max_size --> --> 71680 --> The maximum size (in bytes) of proxy data to transfer via the DNS communication channel at a check in.

#### 17) tcp_frame_header --> --> --> --> Prepend header to TCP Beacon messages

#### 18) tcp_port --> --> 4444 --> Default TCP Beacon listen port

#### 19) uri --> http-get, http-post --> [required option] --> Transaction URI

#### 20) uri_x86 --> http_stager --> --> x86 payload stage URI

#### 21) uri_x64 --> http-stager --> --> x64 payload stage URI

#### 22) useragent --> --> Internet Explorer (Random) --> Default User-Agent for HTTP comms

#### 23) verb --> http-get, http-posty --> GET, POST --> HTTP Verb to use for transaction

### With the uri option, you may specify multiple URIs as a space separated string. Cobalt Strike’s web server will bind all of these URIs and it will assign one of these URIs to each Beacon host when the Beacon stage is built.

### Even though the useragent option exists; you may use the header statement to override this option.

## Additional Considerations for the 'task_' Settings

### The tasks_max_size, tasks_proxy_max_size,and tasks_dns_proxy_max_size work together to create a data buffer to be transferred to beacon when a check in occurs. When the beacon checks in it requests a list of tasks and proxy data that is ready to be transferred to this beacon and its children. The data buffer starts to fill with task(s) followed by proxy data for the parent beacon. Then it continues this pattern for each child beacon until no more tasks or proxy data is available or the tasks_max_size setting will be exceeded by the next task or proxy data.

### The tasks_max_size controls the maximum size in bytes a data buffer filled with tasks and proxy data can be to transfer it to beacon through DNS, HTTP, HTTPS, and Peer-to-Peer communication channels. Most of the time the defaults are fine, however there are occasions when a custom task will exceed the maximum size and cannot be sent. For example, you use the execute-assembly with an executable larger than 1MB in size and the following message is displayed in the team server and beacon consoles.

#### [TeamServer Console] Dropping task for 40147050! Task size of 1389584 bytes is over the max task size limit of 1048576 bytes.

#### [Beacon Console] Task size of 1389584 bytes is over the max task size limit of 1048576 bytes.

### Increasing the tasks_max_size setting will allow this custom task to be sent. However, it will require restarting the team server and generating new beacons as the tasks_max_size is patched into the configuration settings when a beacon is generated and cannot be modified. This setting also affects how much heap memory beacon allocates to process tasks

## Best Practices

### 1) Determine the largest task size that will be sent to a beacon. This can be done through testing and looking for the message above or investigating your custom objects (executables, dlls, etc) that are used in your engagements. Once this is determined add some extra space to the value. Using the information from the above example use 1572864 (1.5 MB) as the tasks_max_size. The reason to have extra space is because a smaller task may follow the larger task to read the response.

### 2) When the tasks_max_size value is determined update the task_max_size setting in your profile and start the team server and generate your beacon artifacts to deploy on your target systems.

### 3) If your infrastructure requires beacons generated from other team servers to connect with each other through Peer-to-Peer communication channels, then this setting should be updated on all team servers. Otherwise, a beacon will ignore a request when it exceeds its configured size.

### 4) If you are using an ExternaC2 listener an update would be required to support tasks_ max_size larger than the default size of 1MB.

### When executing a large task avoid queueing it with other tasks, especially if this is being executed on a beacon using peer-to-peer communication channels (SMB and TCP) as it could be delayed for several check ins depending on the number of already queued tasks and proxy data to send. The reason is when a task is added it has a size of X bytes which reduces the total available space available for adding additional tasks. In addition, proxying data through a beacon will also reduce the amount of available space for sending a large task. When a task is delayed the following message is displayed in the team server and beacon consoles.

#### [Team Server Console] Chunking tasks for 123! Unable to add task of 787984 bytes as it is over the available size of 260486 bytes. 2 task(s) on hold until next checkin.

#### [Beacon Console] Unable to add task of 787984 bytes as it is over the available size of 260486 bytes. 2 task(s) on hold until next checkin.

### The tasks_dns_proxy_max_size (DNS channel) and tasks_proxy_max_size (Other channels) controls the size of proxy data in bytes to be sent to beacon. Both settings need to be less than the tasks_max_size setting. It is recommended not to modify these settings as the default sizes are fine. How these settings work is when it is time to add proxy data to the data buffer for a parent beacon it uses the channels proxy_max_size setting minus the current task length, which can be either a positive or negative value. If it is a positive value, then the proxy data will be added up to that value. if it is a negative value the proxy data is skipped for this check in. For a child beacon the proxy_max_size is temporarily reduced based on the available data buffer space left from processing the parent and prior children.






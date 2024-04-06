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





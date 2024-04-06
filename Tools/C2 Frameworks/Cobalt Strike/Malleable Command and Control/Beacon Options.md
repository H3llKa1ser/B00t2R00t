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

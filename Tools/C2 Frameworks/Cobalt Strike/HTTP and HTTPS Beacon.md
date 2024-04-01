# HTTP and HTTPS Beacon

### The HTTP and HTTPS beacons download tasks with an HTTP GET request. These beacons send data back with an HTTP POST request. This is the default. You have incredible control over the behavior and indicators in this payload via Malleable C2.

## HTTP(S) Listener Setup

### To create a HTTP or HTTPS Beacon listener select Cobalt Strike -> Listeners on the main menu and press the Add button at the bottom of the Listeners tab display.

### The New Listener panel displays.

### Select Beacon HTTP or Beacon HTTPS as the Payload type and give the listener a Name. Make sure to give the new listener a memorable name as this name is how you will refer to this listener through Cobalt Strike’s commands and workflows.

## Parameters

### 1) HTTP(S) Hosts

 - Press [+] to add one or more hosts for the HTTP Beacon to call home
to. Press [-] to remove one or more hosts. Press [X] to clear the current hosts. If
you have multiple hosts, you can still paste a comma-separated list of callback
hosts into this dialog.

 - The length of the beacon host list in beacon payload is limited to 255 characters.
This includes a randomly assigned URI for each host and delimiters between
each item in the list. If the length is exceeded, hosts will be dropped from the end
of the list until it fits in the space. There will be messages in the team server log
for dropped hosts.

### 2) Host Rotation Strategy

 - This value configures the beacons behavior for choosing
which host(s) from the list to use for egress. Select one of the following:

 1) round-robin: Select to loop through the list of host names in the order they are
provided. Each host is used for one connection.

 2) random: Select to randomly select a host name from the list each time a
connection is attempted.

 3) failover-xx: Select to use a working host as long as possible. Use each host in the
list until they reach a consecutive failover count (x) or duration time period
(m,h,d), then use the next host.

 4) rotate-xx: Select to use each host for a period of time. Use each host in the list for
the specified duration (m,h,d), then use the next host.

### 3) Max Retry Strategy

 - This configures the beacons behavior for exiting after a number of
consecutive failed connection attempts to the Team Server. There are several
default options to choose from or you can create your own list with the
LISTENER_MAX_RETRY_STRATEGIES hook.

 1) none: Select to ensure beacon will not exit because of failed connection attempts.

 2) exit-xxx: These settings use the syntax of exit-[max_attempts]-[increase_
attempts]-[duration][m,h,d]. The max_attempt value is the number of
consecutive failed attempts before beacon will exit. The increase_attempts is
the number of consecutive failed attempts before increasing the sleep time.
The duration value is the number of minutes, hours, or days to set the new
sleep time.

The sleep time will not be updated if the current sleep time is greater than the
newly specified duration value. The sleep time will be affected by the current
jitter value.On any successful connection the failed attempts count will be
reset to zero and the sleep time will be reset to the prior value.

### 4) HTTP Host (Stager)

- This controls the host of the HTTP Stager for the HTTP Beacon.
This value is only used if you pair this payload with an attack that requires an
explicit stager.

### 5) Profile

- This is where you select a Malleable C2 profile variant. A variant is a way of
specifying multiple profile variations in one file. With variants, each HTTP or
HTTPS listener you setup can have different network indicators.

### 6) HTTP Port (C2)

 - This field sets the port your HTTP Beacon will phone home to.

### 7) HTTP Port (Bind)

 - - This field specifies the port your HTTP Beacon payload web server
will bind to. These options are useful if you want to setup port bending redirectors
(e.g., a redirector that accepts connections on port 80 or 443 but routes the
connection to your team server on another port).

### 8) HTTP Host Header

 - This value, if specified, is propagated to your HTTP stagers and
through your HTTP communication. This option makes it easier to take
advantage of domain fronting with Cobalt Strike.

### 9) HTTP Proxy

 - Press the … button to specify an explicit proxy configuration for this
payload.

### 10) Guardrails

 - Beacon Guardrails allows the user to create a way to restrict the targets
that the beacon can execute on.Once configured, these values will be the default
guardrail for the Stageless or Windows Stageless Payload Generators.

 - Press the ... button to open the Guardrails Settings:

1) IP Address: Enter a specific IP Address or generic wildcard of the right most
segments. (Example: 123.123.123.123, 123.123.123.*, 123.123.*.*, 123.*.*.*)

2) User Name: Enter a specific name, or a value that:
   “starts with”supported by “*” wildcard character on the right side
   “ends with”supported by “*” wildcard character on the left side
The guard is case-insensitive.

3) Server Name: Enter a specific computer name, or a value that:
“starts with”supported by “*” wildcard character on the right side
   “ends with”supported by “*” wildcard character on the left side
The guard is case-insensitive.

4) Domain: Enter a specific domain or value that:
   “starts with”supported by “*” wildcard character on the right side
   “ends with”supported by “*” wildcard character on the left side
The guard is case-insensitive.


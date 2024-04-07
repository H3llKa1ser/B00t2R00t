# HTTP Server Configuration

### The http-config block has influence over all HTTP responses served by Cobalt Strike’s web server. Here, you may specify additional HTTP headers and the HTTP header order.

http-config {
set headers "Date, Server, Content-Length, Keep-Alive,
Connection, Content-Type";
header "Server" "Apache";
header "Keep-Alive" "timeout=5, max=100";
header "Connection" "Keep-Alive”;
set trust_x_forwarded_for "true";
set block_useragents "curl*,lynx*,wget*";
}


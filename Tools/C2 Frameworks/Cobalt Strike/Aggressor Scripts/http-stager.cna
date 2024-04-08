http-stager {
set uri_x86 "/get32.gif";
set uri_x64 "/get64.gif";

client {
parameter "id" "1234";
header "Cookie" "SomeValue";
}

server {
header "Content-Type" "image/gif";
output {
prepend "GIF89a";
print;
  }
}

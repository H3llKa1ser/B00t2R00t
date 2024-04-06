# Strings, Headers and Parameters

### Beacon’s Profile Language allows you to use “strings”in several places. In general, strings are interpreted as-is. However, there are a few special values that you may use in a string:

 - “\n”: Newline character

 - “\r” Carriage Return

 - “\t” Tab character

 - “\u####”: A unicode character

 - “\x##”: A byte (e.g., \x41 = ‘A’)
 
 - “\\”:  \

# Headers and Parameters

### Data transforms are an important part of the indicator customization process. They allow you to dress up data that Beacon must send or receive with each transaction. You may add extraneous indicators to each transaction too.

### In an HTTP GET or POST request, these extraneous indicators come in the form of headers or parameters. Use the parameter statement within the client block to add an arbitrary parameter to an HTTP GET or POST transaction.

### This code will force Beacon to add ?bar=blah to the /foobar URI when it makes a request.

http-get {
    client {
         parameter "bar" "blah";


### Use the header statement within the client or server blocks to add an arbitrary HTTP header to the client’s request or server’s response. This header statement adds an indicator to put network security monitoring teams at ease.

http-get {
       server {
           header "X-Not-Malware" "I promise!";


### The Profile Interpreter will Interpret your header and parameter statements In order. That said, the WinINet or WinHTTP (client) and Cobalt Strike web server have the final say about where in the transaction these indicators will appear.


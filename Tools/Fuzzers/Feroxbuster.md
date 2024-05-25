# Feroxbuster, an improved directory fuzzer tool

## Commands:

 - feroxbuster -u http://DOMAIN.LOCAL/ -w /path/to/wordlist.txt (Main command. Has recursion 4 by default.)

 - -k (Skips TLS Certificate checks. Scan web apps on port 443(HTTPS))

 - -C STATUS_CODE (Filters based on status code)

 - -S SIZE (Filters based on size)

 - -W WORDS (Filters based on word count)

 - -b , --cookies COOKIE (Specify HTTP cookies to be used in each request. Ex: -b PHPSESSID=9G7D89GDF89G7)

 - -Q , --query QUERY (Request URL query parameters. Ex: -Q token=TOKEN or -Q secret=key)

 - -H , --headers HEADER (Specify HTTP headers to be used in each request. Ex: -H Header:value or -H 'stuff: things')

 - -m , --methods METHOD (Which HTTP request method(s) should be sent. Default method is GET)

 - -x , --extensions FILE_EXTENSION (File extension(s) to search for. Ex: -x php or -x txt pdf)

 - -A , --random-agent (Use a random User-Agent)

 - -a , --user-agent USER_AGENT (Sets the User-Agent)

 - -n , --no-recursion (Scan without recursion)

 - -d , --depth RECURSION_DEPTH (Maximum recursion depth, a depth of 0 is INFINITE recursion. Default is 4)

 - -e, --extract-links (Extract links from response body (html, javascript, etc...), make new requests based on findings)

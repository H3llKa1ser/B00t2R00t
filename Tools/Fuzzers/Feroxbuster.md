# Feroxbuster, an improved directory fuzzer tool

## Commands:

 - feroxbuster -u http://DOMAIN.LOCAL/ -w /path/to/wordlist.txt (Main command. Has recursion 4 by default.)

 - -C NUM (Filters based on status code)

 - -S NUM (Filters based on size)

 - -b , --cookies COOKIE (Specify HTTP cookies to be used in each request. Ex: -b PHPSESSID=9G7D89GDF89G7)

 - -Q , --query QUERY (Request URL query parameters. Ex: -Q token=TOKEN or -Q secret=key)

 - -H , --headers HEADER (Specify HTTP headers to be used in each request. Ex: -H Header:value or -H 'stuff: things')

 - -m , --methods METHOD (Which HTTP request method(s) should be sent. Default method is GET)

 - -x , --extensions FILE_EXTENSION (File extension(s) to search for. Ex: -x php or -x txt pdf)

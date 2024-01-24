## One liner command for creating IIS extensions to test against a server with burp intruder

#### curl --silent https://msdn.microsoft.com/en-us/library/2wawkw1c.aspx | grep "<p>." | awk -F">" '{print $2}'| awk -F"<" '{print $1}' | tr ' ' '\n' | grep "^\." | sed -e 's/,//g' > iis_extensions.txt

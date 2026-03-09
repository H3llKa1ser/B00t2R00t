#!/usr/bin/env python3
"""
BugBountyRecon - Comprehensive Reconnaissance Tool for Bug Bounty Hunting
=========================================================================
Version: 2.0 | License: MIT | For authorized security testing only.

Install: pip install requests beautifulsoup4 dnspython python-whois
Usage:   python bugbounty_recon.py -d example.com
"""

import socket, ssl, json, csv, sys, os, re, time, argparse, hashlib
import urllib.parse, concurrent.futures
from datetime import datetime
from typing import List, Dict, Set, Optional

# Conditional imports
HAVE_REQUESTS = HAVE_BS4 = HAVE_DNS = HAVE_WHOIS = False
try:
    import requests
    from requests.adapters import HTTPAdapter
    from urllib3.util.retry import Retry
    requests.packages.urllib3.disable_warnings()
    HAVE_REQUESTS = True
except ImportError: pass
try:
    from bs4 import BeautifulSoup
    HAVE_BS4 = True
except ImportError: pass
try:
    import dns.resolver, dns.zone, dns.query
    HAVE_DNS = True
except ImportError: pass
try:
    import whois
    HAVE_WHOIS = True
except ImportError: pass

# ═══════════════════════════════════════════════════════════════════════
# UTILITIES
# ═══════════════════════════════════════════════════════════════════════

class Colors:
    RED="\033[91m"; GREEN="\033[92m"; YELLOW="\033[93m"; BLUE="\033[94m"
    MAGENTA="\033[95m"; CYAN="\033[96m"; WHITE="\033[97m"
    BOLD="\033[1m"; RESET="\033[0m"
    @staticmethod
    def disable():
        for a in ['RED','GREEN','YELLOW','BLUE','MAGENTA','CYAN','WHITE','BOLD','RESET']:
            setattr(Colors, a, "")

class Logger:
    @staticmethod
    def banner():
        print(f"""
{Colors.CYAN}{Colors.BOLD}
 ____              ____                    _         ____
| __ ) _   _  __ _| __ )  ___  _   _ _ __ | |_ _   _|  _ \\ ___  ___ ___  _ __
|  _ \\| | | |/ _` |  _ \\ / _ \\| | | | '_ \\| __| | | | |_) / _ \\/ __/ _ \\| '_ \\
| |_) | |_| | (_| | |_) | (_) | |_| | | | | |_| |_| |  _ <  __/ (_| (_) | | | |
|____/ \\__,_|\\__, |____/ \\___/ \\__,_|_| |_|\\__|\\__, |_| \\_\\___|\\___\\___/|_| |_|
             |___/                              |___/
{Colors.RESET}
{Colors.YELLOW}  [ Bug Bounty Reconnaissance Tool v2.0 ]{Colors.RESET}
{Colors.RED}  [ For Authorized Security Testing Only ]{Colors.RESET}
""")
    @staticmethod
    def info(msg): print(f"  {Colors.BLUE}[INFO]{Colors.RESET}  {msg}")
    @staticmethod
    def success(msg): print(f"  {Colors.GREEN}[+]{Colors.RESET}     {msg}")
    @staticmethod
    def warning(msg): print(f"  {Colors.YELLOW}[!]{Colors.RESET}     {msg}")
    @staticmethod
    def error(msg): print(f"  {Colors.RED}[-]{Colors.RESET}     {msg}")
    @staticmethod
    def section(title):
        print(f"\n  {Colors.MAGENTA}{Colors.BOLD}{'=' * 60}{Colors.RESET}")
        print(f"  {Colors.MAGENTA}{Colors.BOLD}  {title.upper()}{Colors.RESET}")
        print(f"  {Colors.MAGENTA}{Colors.BOLD}{'=' * 60}{Colors.RESET}\n")
    @staticmethod
    def progress(current, total, prefix=""):
        filled = int(30 * current / total) if total else 0
        bar = "\u2588" * filled + "\u2591" * (30 - filled)
        pct = current / total * 100 if total else 0
        print(f"\r  {Colors.CYAN}{prefix} [{bar}] {pct:.0f}%{Colors.RESET}", end="", flush=True)
        if current == total: print()


class HTTPClient:
    def __init__(self, timeout=10, max_retries=3, rate_limit=0.1, user_agent=None):
        self.timeout = timeout
        self.rate_limit = rate_limit
        self._last = 0.0
        self.session = requests.Session() if HAVE_REQUESTS else None
        if self.session:
            retry = Retry(total=max_retries, backoff_factor=0.5,
                          status_forcelist=[429,500,502,503,504])
            adapter = HTTPAdapter(max_retries=retry, pool_maxsize=20)
            self.session.mount("http://", adapter)
            self.session.mount("https://", adapter)
            self.session.headers["User-Agent"] = user_agent or \
                "Mozilla/5.0 (X11; Linux x86_64) Chrome/120.0.0.0 Safari/537.36"

    def get(self, url, **kw):
        if not self.session: return None
        elapsed = time.time() - self._last
        if elapsed < self.rate_limit: time.sleep(self.rate_limit - elapsed)
        self._last = time.time()
        try:
            kw.setdefault("timeout", self.timeout)
            kw.setdefault("verify", False)
            kw.setdefault("allow_redirects", True)
            return self.session.get(url, **kw)
        except: return None


# ═══════════════════════════════════════════════════════════════════════
# MODULE 1: SUBDOMAIN ENUMERATION
# ═══════════════════════════════════════════════════════════════════════

class SubdomainEnumerator:
    COMMON_SUBS = [
        "www","mail","ftp","admin","blog","dev","staging","test","api","app",
        "m","mobile","portal","vpn","remote","secure","shop","store","cdn",
        "media","static","assets","img","images","ns1","ns2","dns","mx",
        "smtp","pop","imap","webmail","cpanel","whm","dashboard","panel",
        "login","auth","sso","gateway","proxy","lb","edge","node","server",
        "db","database","sql","mysql","postgres","mongo","redis","cache",
        "git","gitlab","jenkins","ci","docker","k8s","registry","grafana",
        "kibana","elastic","prometheus","monitor","status","docs","wiki",
        "help","support","jira","confluence","beta","alpha","demo","sandbox",
        "stage","uat","qa","internal","intranet","corp","backup","old","v2","v3",
    ]

    def __init__(self, domain, http, wordlist=None):
        self.domain = domain
        self.http = http
        self.subs: Set[str] = set()
        self.wordlist = wordlist

    def _add(self, s):
        s = s.strip().lower().rstrip(".")
        if s and (s.endswith(f".{self.domain}") or s == self.domain) and "*" not in s:
            self.subs.add(s)

    def enumerate_all(self) -> Set[str]:
        Logger.section("Subdomain Enumeration")
        for name, fn in [
            ("crt.sh", self._crtsh), ("DNS Brute Force", self._dns_brute),
            ("Wayback Machine", self._wayback), ("HackerTarget", self._hackertarget),
            ("BufferOver", self._bufferover), ("RapidDNS", self._rapiddns),
        ]:
            try:
                Logger.info(f"Querying {name}...")
                before = len(self.subs); fn()
                found = len(self.subs) - before
                (Logger.success if found else Logger.info)(f"{name}: {found} new")
            except Exception as e:
                Logger.warning(f"{name} failed: {e}")
        Logger.success(f"Total unique subdomains: {len(self.subs)}")
        return self.subs

    def _crtsh(self):
        r = self.http.get(f"https://crt.sh/?q=%25.{self.domain}&output=json")
        if r and r.status_code == 200:
            for e in r.json():
                for n in e.get("name_value","").split("\n"): self._add(n)

    def _wayback(self):
        r = self.http.get(f"http://web.archive.org/cdx/search/cdx?url=*.{self.domain}/*&output=json&fl=original&collapse=urlkey&limit=5000", timeout=30)
        if r and r.status_code == 200:
            for row in r.json()[1:]:
                try: self._add(urllib.parse.urlparse(row[0]).hostname or "")
                except: pass

    def _hackertarget(self):
        r = self.http.get(f"https://api.hackertarget.com/hostsearch/?q={self.domain}")
        if r and r.status_code == 200 and "error" not in r.text.lower():
            for line in r.text.splitlines():
                p = line.split(",")
                if p: self._add(p[0])

    def _bufferover(self):
        r = self.http.get(f"https://dns.bufferover.run/dns?q=.{self.domain}")
        if r and r.status_code == 200:
            d = r.json()
            for rec in d.get("FDNS_A",[]) + d.get("RDNS",[]):
                p = rec.split(",")
                if len(p) >= 2: self._add(p[1])

    def _rapiddns(self):
        r = self.http.get(f"https://rapiddns.io/subdomain/{self.domain}?full=1")
        if r and r.status_code == 200 and HAVE_BS4:
            for td in BeautifulSoup(r.text, "html.parser").find_all("td"):
                t = td.get_text(strip=True)
                if t.endswith(f".{self.domain}"): self._add(t)

    def _dns_brute(self):
        if not HAVE_DNS:
            Logger.warning("dnspython not installed - skipping"); return
        words = self.COMMON_SUBS
        if self.wordlist and os.path.isfile(self.wordlist):
            with open(self.wordlist) as f:
                words = [l.strip() for l in f if l.strip()]
        resolver = dns.resolver.Resolver()
        resolver.timeout = resolver.lifetime = 3
        def check(w):
            fqdn = f"{w}.{self.domain}"
            try:
                if resolver.resolve(fqdn, "A"): return fqdn
            except: pass
        with concurrent.futures.ThreadPoolExecutor(max_workers=30) as pool:
            futs = {pool.submit(check, w): w for w in words}
            done = 0
            for f in concurrent.futures.as_completed(futs):
                done += 1
                if done % 20 == 0 or done == len(words):
                    Logger.progress(done, len(words), "DNS Brute")
                r = f.result()
                if r: self._add(r)


# ═══════════════════════════════════════════════════════════════════════
# MODULE 2: DNS INTELLIGENCE
# ═══════════════════════════════════════════════════════════════════════

class DNSIntelligence:
    RTYPES = ["A","AAAA","MX","NS","TXT","CNAME","SOA","SRV","CAA","PTR"]

    def __init__(self, domain): self.domain = domain; self.records = {}

    def gather(self) -> Dict:
        Logger.section("DNS Intelligence")
        if not HAVE_DNS:
            Logger.warning("dnspython not installed - socket fallback")
            try:
                ips = socket.getaddrinfo(self.domain, None)
                self.records["A"] = list({a[4][0] for a in ips if a[0]==socket.AF_INET})
                if self.records["A"]: Logger.success(f"A -> {self.records['A']}")
            except Exception as e: Logger.error(str(e))
            return self.records

        res = dns.resolver.Resolver(); res.timeout = res.lifetime = 5
        for rt in self.RTYPES:
            try:
                ans = res.resolve(self.domain, rt)
                self.records[rt] = [str(r) for r in ans]
                Logger.success(f"{rt:6s} -> {len(self.records[rt])} record(s)")
                for r in self.records[rt][:5]: Logger.info(f"         {r}")
            except dns.resolver.NXDOMAIN:
                Logger.error(f"Domain does not exist!"); break
            except: pass

        # Zone transfer check
        try:
            for ns in res.resolve(self.domain, "NS"):
                try:
                    z = dns.zone.from_xfr(dns.query.xfr(str(ns).rstrip("."), self.domain, timeout=5))
                    if z:
                        Logger.warning(f"ZONE TRANSFER on {ns}! (CRITICAL)")
                        self.records["AXFR"] = [str(n) for n in z.nodes.keys()]
                except: pass
        except: pass

        # Wildcard check
        rand = f"nx-{hashlib.md5(str(time.time()).encode()).hexdigest()[:8]}.{self.domain}"
        try:
            res.resolve(rand, "A")
            Logger.warning("Wildcard DNS detected")
            self.records["_wildcard"] = ["true"]
        except: Logger.info("No wildcard DNS")

        return self.records


# ═══════════════════════════════════════════════════════════════════════
# MODULE 3: HTTP PROBING
# ═══════════════════════════════════════════════════════════════════════

class HTTPProber:
    def __init__(self, http): self.http = http; self.results = []

    def probe(self, hosts: Set[str]) -> List[Dict]:
        Logger.section("HTTP Probing")
        Logger.info(f"Probing {len(hosts)} host(s)...")
        if not HAVE_REQUESTS: Logger.error("requests required"); return []

        def check(host):
            for scheme in ["https","http"]:
                url = f"{scheme}://{host}"
                try:
                    r = self.http.get(url, timeout=8)
                    if r:
                        return {"host":host,"url":url,"status_code":r.status_code,
                                "content_length":len(r.content),
                                "title":self._title(r.text),
                                "server":r.headers.get("Server",""),
                                "technologies":self._techs(r),
                                "redirect_url":r.url if r.url!=url else "",
                                "headers":dict(r.headers)}
                except: pass
            return None

        with concurrent.futures.ThreadPoolExecutor(max_workers=15) as pool:
            futs = {pool.submit(check, h): h for h in hosts}
            done = 0
            for f in concurrent.futures.as_completed(futs):
                done += 1; Logger.progress(done, len(futs), "Probing")
                r = f.result()
                if r:
                    self.results.append(r)
                    c = Colors.GREEN if r["status_code"]<300 else Colors.YELLOW if r["status_code"]<400 else Colors.RED
                    Logger.success(f"{c}[{r['status_code']}]{Colors.RESET} {r['url']} - {(r['title'] or 'No Title')[:50]} | {r['server']}")
        Logger.success(f"Live hosts: {len(self.results)}")
        return self.results

    def _title(self, html):
        if HAVE_BS4:
            t = BeautifulSoup(html,"html.parser").find("title")
            return t.get_text(strip=True) if t else ""
        m = re.search(r"<title[^>]*>(.*?)</title>", html, re.I|re.DOTALL)
        return m.group(1).strip() if m else ""

    def _techs(self, resp) -> List[str]:
        t = []
        h = {k.lower():v for k,v in resp.headers.items()}
        if "x-powered-by" in h: t.append(h["x-powered-by"])
        srv = h.get("server","").lower()
        for k,n in {"nginx":"Nginx","apache":"Apache","iis":"IIS","cloudflare":"Cloudflare"}.items():
            if k in srv: t.append(n)
        ck = h.get("set-cookie","").lower()
        for p,n in {"phpsessid":"PHP","jsessionid":"Java","csrftoken":"Django","laravel_session":"Laravel","wordpress_":"WordPress"}.items():
            if p in ck: t.append(n)
        body = resp.text[:10000].lower()
        for s,n in {"wp-content":"WordPress","react":"React","vue.js":"Vue.js","angular":"Angular","jquery":"jQuery","bootstrap":"Bootstrap","next.js":"Next.js"}.items():
            if s in body and n not in t: t.append(n)
        return list(set(t))


# ═══════════════════════════════════════════════════════════════════════
# MODULE 4: PORT SCANNER
# ═══════════════════════════════════════════════════════════════════════

class PortScanner:
    PORTS = [21,22,23,25,53,80,110,111,135,139,143,443,445,993,995,
             1433,1521,2049,2082,2083,3000,3306,3389,4443,5432,5900,
             6379,8000,8008,8080,8443,8888,9090,9200,9443,27017]
    SVCS = {21:"FTP",22:"SSH",23:"Telnet",25:"SMTP",53:"DNS",80:"HTTP",
            110:"POP3",143:"IMAP",443:"HTTPS",445:"SMB",1433:"MSSQL",
            3306:"MySQL",3389:"RDP",5432:"PostgreSQL",5900:"VNC",
            6379:"Redis",8080:"HTTP-Proxy",8443:"HTTPS-Alt",9200:"Elasticsearch",27017:"MongoDB"}

    def __init__(self, timeout=1.5): self.timeout = timeout

    def scan(self, host, ports=None) -> List[Dict]:
        Logger.section(f"Port Scan: {host}")
        ports = ports or self.PORTS; results = []
        try: ip = socket.gethostbyname(host); Logger.info(f"Resolved -> {ip}")
        except: Logger.error(f"Cannot resolve {host}"); return []

        def check(port):
            try:
                s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
                s.settimeout(self.timeout)
                if s.connect_ex((ip, port)) == 0:
                    s.close()
                    return {"port":port,"service":self.SVCS.get(port,"Unknown"),
                            "banner":self._banner(ip,port),"state":"open"}
                s.close()
            except: pass
            return None

        with concurrent.futures.ThreadPoolExecutor(max_workers=50) as pool:
            futs = {pool.submit(check, p): p for p in ports}
            done = 0
            for f in concurrent.futures.as_completed(futs):
                done += 1
                if done % 10 == 0 or done == len(ports):
                    Logger.progress(done, len(ports), "Scanning")
                r = f.result()
                if r:
                    results.append(r)
                    Logger.success(f"Port {r['port']:5d}/tcp OPEN {r['service']} {r['banner'][:60] if r['banner'] else ''}")
        results.sort(key=lambda x: x["port"])
        Logger.success(f"Open: {len(results)}/{len(ports)}")
        return results

    def _banner(self, ip, port):
        try:
            s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
            s.settimeout(2); s.connect((ip, port))
            s.send(b"HEAD / HTTP/1.0\r\nHost: target\r\n\r\n" if port in (80,443,8080,8443) else b"\r\n")
            b = s.recv(512).decode("utf-8", errors="ignore").strip(); s.close()
            return b.split("\n")[0][:100]
        except: return ""


# ═══════════════════════════════════════════════════════════════════════
# MODULE 5: SECURITY HEADER ANALYSIS
# ═══════════════════════════════════════════════════════════════════════

class SecurityHeaderAnalyzer:
    HEADERS = {
        "Strict-Transport-Security": ("HIGH","HSTS not set - protocol downgrade risk"),
        "Content-Security-Policy": ("HIGH","CSP not set - XSS/injection risk"),
        "X-Frame-Options": ("MEDIUM","Clickjacking risk"),
        "X-Content-Type-Options": ("MEDIUM","MIME sniffing risk"),
        "X-XSS-Protection": ("LOW","Legacy XSS protection missing"),
        "Referrer-Policy": ("LOW","May leak URL info"),
        "Permissions-Policy": ("MEDIUM","Browser features unrestricted"),
        "Cross-Origin-Opener-Policy": ("LOW","Cross-origin info leak risk"),
        "Cross-Origin-Resource-Policy": ("LOW","Cross-origin resource loading"),
    }
    LEAK = ["Server","X-Powered-By","X-AspNet-Version","X-AspNetMvc-Version","X-Runtime","X-Generator"]

    def analyze(self, headers, url) -> Dict:
        Logger.section(f"Security Headers: {url}")
        findings = {"missing":[],"present":[],"info_leak":[],"score":0}
        ct = 0
        for h,(sev,desc) in self.HEADERS.items():
            if h.lower() in {k.lower() for k in headers}:
                ct += 1; findings["present"].append({"header":h,"value":headers.get(h,"")})
                Logger.success(f"  {h}")
            else:
                findings["missing"].append({"header":h,"severity":sev,"description":desc})
                c = Colors.RED if sev=="HIGH" else Colors.YELLOW
                Logger.warning(f"  {c}[{sev}]{Colors.RESET} {desc}")
        for h in self.LEAK:
            for k,v in headers.items():
                if k.lower() == h.lower():
                    findings["info_leak"].append({"header":k,"value":v})
                    Logger.warning(f"  Info Leak: {k}: {v}")
        findings["score"] = int(ct/len(self.HEADERS)*100)
        g = "A" if findings["score"]>=90 else "B" if findings["score"]>=70 else "C" if findings["score"]>=50 else "D" if findings["score"]>=30 else "F"
        Logger.info(f"Score: {findings['score']}% (Grade: {g})")
        return findings


# ═══════════════════════════════════════════════════════════════════════
# MODULE 6: SSL/TLS ANALYSIS
# ═══════════════════════════════════════════════════════════════════════

class SSLAnalyzer:
    def analyze(self, hostname) -> Dict:
        Logger.section(f"SSL/TLS: {hostname}")
        result = {"valid":False,"details":{}}
        try:
            ctx = ssl.create_default_context()
            with socket.create_connection((hostname, 443), timeout=10) as sock:
                with ctx.wrap_socket(sock, server_hostname=hostname) as ss:
                    cert = ss.getpeercert(); cipher = ss.cipher(); proto = ss.version()
                    d = {
                        "subject": dict(x[0] for x in cert.get("subject",[])),
                        "issuer": dict(x[0] for x in cert.get("issuer",[])),
                        "not_before": cert.get("notBefore"),
                        "not_after": cert.get("notAfter"),
                        "san": [e[1] for e in cert.get("subjectAltName",[])],
                        "protocol": proto,
                        "cipher": cipher[0] if cipher else "",
                        "bits": cipher[2] if cipher and len(cipher)>2 else 0,
                    }
                    result["valid"] = True; result["details"] = d
                    Logger.success("Certificate Valid")
                    Logger.info(f"  Subject:  {d['subject'].get('commonName','N/A')}")
                    Logger.info(f"  Issuer:   {d['issuer'].get('organizationName','N/A')}")
                    Logger.info(f"  Expires:  {d['not_after']}")
                    Logger.info(f"  Protocol: {proto} | Cipher: {d['cipher']} ({d['bits']} bits)")
                    Logger.info(f"  SANs: {len(d['san'])}")
                    for s in d["san"][:10]: Logger.info(f"    - {s}")
        except ssl.SSLCertVerificationError as e:
            Logger.warning(f"SSL Verify Failed: {e}"); result["details"]["error"]=str(e)
        except Exception as e:
            Logger.error(f"SSL failed: {e}"); result["details"]["error"]=str(e)
        return result


# ═══════════════════════════════════════════════════════════════════════
# MODULE 7: WAYBACK HARVESTER
# ═══════════════════════════════════════════════════════════════════════

class WaybackHarvester:
    EXTS = {".php",".asp",".aspx",".jsp",".json",".xml",".yaml",".yml",
            ".conf",".config",".env",".bak",".backup",".old",".sql",".db",
            ".log",".txt",".zip",".tar",".gz",".git",".svn",".htaccess",
            ".htpasswd",".key",".pem",".crt"}

    def __init__(self, domain, http): self.domain=domain; self.http=http

    def harvest(self) -> Dict:
        Logger.section("Wayback Machine")
        res = {"urls":[],"parameters":set(),"js_files":[],"interesting_files":[]}
        r = self.http.get(f"http://web.archive.org/cdx/search/cdx?url=*.{self.domain}/*&output=json&fl=original,statuscode,mimetype&collapse=urlkey&limit=10000", timeout=60)
        if not r or r.status_code != 200:
            Logger.error("Wayback fetch failed"); return res
        try: data = r.json()
        except: Logger.error("Parse failed"); return res

        for row in data[1:]:
            url = row[0]; res["urls"].append(url)
            parsed = urllib.parse.urlparse(url)
            res["parameters"].update(urllib.parse.parse_qs(parsed.query).keys())
            pl = parsed.path.lower()
            if pl.endswith(".js"): res["js_files"].append(url)
            for ext in self.EXTS:
                if pl.endswith(ext): res["interesting_files"].append(url); break
        res["parameters"] = list(res["parameters"])
        Logger.success(f"URLs: {len(res['urls'])} | Params: {len(res['parameters'])} | JS: {len(res['js_files'])} | Interesting: {len(res['interesting_files'])}")
        if res["parameters"]: Logger.info("Params: " + ", ".join(sorted(res["parameters"])[:30]))
        for f in res["interesting_files"][:15]: Logger.info(f"  -> {f}")
        return res


# ═══════════════════════════════════════════════════════════════════════
# MODULE 8: WEB CRAWLER
# ═══════════════════════════════════════════════════════════════════════

class WebCrawler:
    def __init__(self, http, max_depth=3, max_pages=100):
        self.http=http; self.max_depth=max_depth; self.max_pages=max_pages
        self.visited: Set[str] = set()
        self.results = {"endpoints":[],"forms":[],"js_files":[],"emails":set(),"comments":[],"external_links":[]}

    def crawl(self, base_url) -> Dict:
        Logger.section(f"Crawling: {base_url}")
        if not HAVE_BS4: Logger.error("BS4 required"); return self.results
        self.base_domain = urllib.parse.urlparse(base_url).netloc
        self._crawl(base_url, 0)
        self.results["emails"] = list(self.results["emails"])
        Logger.success(f"Pages: {len(self.visited)} | Endpoints: {len(self.results['endpoints'])} | Forms: {len(self.results['forms'])} | JS: {len(self.results['js_files'])} | Emails: {len(self.results['emails'])}")
        return self.results

    def _crawl(self, url, depth):
        if depth > self.max_depth or len(self.visited) >= self.max_pages or url in self.visited: return
        self.visited.add(url)
        r = self.http.get(url)
        if not r or r.status_code != 200 or "text/html" not in r.headers.get("Content-Type","").lower(): return
        soup = BeautifulSoup(r.text, "html.parser")

        for a in soup.find_all("a", href=True):
            full = urllib.parse.urljoin(url, a["href"])
            p = urllib.parse.urlparse(full)
            if p.netloc == self.base_domain:
                clean = f"{p.scheme}://{p.netloc}{p.path}"
                if clean not in self.visited:
                    self.results["endpoints"].append(full)
                    self._crawl(clean, depth+1)
            else: self.results["external_links"].append(full)

        for form in soup.find_all("form"):
            fd = {"action":urllib.parse.urljoin(url,form.get("action","")),"method":form.get("method","GET").upper(),"inputs":[]}
            for inp in form.find_all(["input","textarea","select"]):
                fd["inputs"].append({"name":inp.get("name",""),"type":inp.get("type","text"),"value":inp.get("value","")})
            self.results["forms"].append(fd)

        for sc in soup.find_all("script", src=True):
            js = urllib.parse.urljoin(url, sc["src"])
            if js not in self.results["js_files"]: self.results["js_files"].append(js)

        self.results["emails"].update(re.findall(r"[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}", r.text))
        for c in re.findall(r"<!--(.*?)-->", r.text, re.DOTALL):
            if len(c.strip()) > 5: self.results["comments"].append(c.strip()[:200])


# ═══════════════════════════════════════════════════════════════════════
# MODULE 9: WHOIS
# ═══════════════════════════════════════════════════════════════════════

class WHOISLookup:
    def lookup(self, domain) -> Dict:
        Logger.section(f"WHOIS: {domain}")
        if HAVE_WHOIS:
            try:
                w = whois.whois(domain)
                r = {"domain":w.domain_name,"registrar":w.registrar,
                     "created":str(w.creation_date),"expires":str(w.expiration_date),
                     "nameservers":w.name_servers,"emails":w.emails}
                for k,v in r.items():
                    if v: Logger.info(f"  {k:15s}: {v}")
                return r
            except Exception as e: Logger.error(str(e))
        # Socket fallback
        try:
            s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
            s.settimeout(10); s.connect(("whois.iana.org", 43))
            s.send(f"{domain}\r\n".encode())
            resp = b""
            while True:
                chunk = s.recv(4096)
                if not chunk: break
                resp += chunk
            s.close()
            text = resp.decode("utf-8", errors="ignore")
            for line in text.strip().splitlines()[:20]: Logger.info(f"  {line}")
            return {"raw": text}
        except Exception as e: Logger.error(str(e)); return {}


# ═══════════════════════════════════════════════════════════════════════
# MODULE 10: REPORT GENERATOR
# ═══════════════════════════════════════════════════════════════════════

class ReportGenerator:
    def __init__(self, domain, output_dir):
        self.domain=domain; self.out=output_dir; os.makedirs(output_dir, exist_ok=True)

    def generate_json(self, data):
        path = os.path.join(self.out, f"recon_{self.domain}.json")
        with open(path,"w") as f:
            json.dump(data, f, indent=2, default=lambda o: list(o) if isinstance(o,set) else str(o))
        Logger.success(f"JSON: {path}"); return path

    def generate_html(self, data):
        path = os.path.join(self.out, f"recon_{self.domain}.html")
        subs = data.get("subdomains",[]); hosts = data.get("live_hosts",[]); ports = data.get("open_ports",[])
        html = f"""<!DOCTYPE html><html><head><meta charset="UTF-8"><title>Recon: {self.domain}</title>
<style>*{{box-sizing:border-box;margin:0;padding:0}}body{{font-family:'Segoe UI',sans-serif;background:#0d1117;color:#c9d1d9;padding:20px}}
.c{{max-width:1200px;margin:0 auto}}h1{{color:#58a6ff;border-bottom:2px solid #30363d;padding-bottom:10px;margin-bottom:20px}}
h2{{color:#79c0ff;margin:20px 0 10px}}.card{{background:#161b22;border:1px solid #30363d;border-radius:8px;padding:16px;margin:10px 0}}
table{{width:100%;border-collapse:collapse}}th,td{{text-align:left;padding:8px;border:1px solid #30363d}}
th{{background:#21262d;color:#79c0ff}}tr:hover{{background:#1c2128}}code{{background:#21262d;padding:2px 6px;border-radius:4px;font-family:monospace}}
.s{{display:inline-block;background:#21262d;padding:10px 20px;border-radius:8px;margin:5px;text-align:center}}
.sn{{font-size:24px;font-weight:bold;color:#58a6ff}}.sl{{font-size:12px;color:#8b949e}}
.bg{{display:inline-block;padding:2px 8px;border-radius:12px;font-size:12px;font-weight:bold}}
.bh{{background:#f85149;color:#fff}}.bm{{background:#d29922;color:#fff}}.bo{{background:#3fb950;color:#fff}}</style></head>
<body><div class="c"><h1>Recon Report: {self.domain}</h1>
<p style="color:#8b949e">Generated: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}</p>
<div style="margin:20px 0">
<div class="s"><div class="sn">{len(subs)}</div><div class="sl">Subdomains</div></div>
<div class="s"><div class="sn">{len(hosts)}</div><div class="sl">Live Hosts</div></div>
<div class="s"><div class="sn">{len(ports)}</div><div class="sl">Open Ports</div></div>
<div class="s"><div class="sn">{len(data.get('wayback',{}).get('parameters',[]))}</div><div class="sl">Parameters</div></div></div>"""

        if subs:
            html += '<h2>Subdomains</h2><div class="card"><table><tr><th>#</th><th>Subdomain</th></tr>'
            for i,s in enumerate(sorted(subs),1): html += f"<tr><td>{i}</td><td><code>{s}</code></td></tr>"
            html += "</table></div>"
        if hosts:
            html += '<h2>Live Hosts</h2><div class="card"><table><tr><th>URL</th><th>Status</th><th>Title</th><th>Server</th><th>Tech</th></tr>'
            for h in hosts:
                c = "bo" if h["status_code"]<300 else "bm" if h["status_code"]<400 else "bh"
                html += f'<tr><td><code>{h["url"]}</code></td><td><span class="bg {c}">{h["status_code"]}</span></td><td>{h.get("title","")[:50]}</td><td>{h.get("server","")}</td><td>{",".join(h.get("technologies",[]))}</td></tr>'
            html += "</table></div>"
        if ports:
            html += '<h2>Open Ports</h2><div class="card"><table><tr><th>Port</th><th>Service</th><th>Banner</th></tr>'
            for p in ports: html += f'<tr><td><span class="bg bo">{p["port"]}</span></td><td>{p["service"]}</td><td><code>{p.get("banner","")[:80]}</code></td></tr>'
            html += "</table></div>"
        html += "</div></body></html>"
        with open(path,"w") as f: f.write(html)
        Logger.success(f"HTML: {path}"); return path

    def generate_csv(self, data):
        path = os.path.join(self.out, f"recon_{self.domain}.csv")
        with open(path,"w",newline="") as f:
            w = csv.writer(f)
            w.writerow(["=== SUBDOMAINS ==="]); w.writerow(["Subdomain"])
            for s in sorted(data.get("subdomains",[])): w.writerow([s])
            w.writerow([]); w.writerow(["=== LIVE HOSTS ==="])
            w.writerow(["URL","Status","Title","Server","Tech"])
            for h in data.get("live_hosts",[]):
                w.writerow([h["url"],h["status_code"],h.get("title",""),h.get("server",""),"|".join(h.get("technologies",[]))])
            w.writerow([]); w.writerow(["=== OPEN PORTS ==="]); w.writerow(["Port","Service","Banner"])
            for p in data.get("open_ports",[]): w.writerow([p["port"],p["service"],p.get("banner","")])
        Logger.success(f"CSV: {path}"); return path


# ═══════════════════════════════════════════════════════════════════════
# ORCHESTRATOR
# ═══════════════════════════════════════════════════════════════════════

class BugBountyRecon:
    def __init__(self, args):
        self.domain = args.domain.strip().lower()
        self.args = args
        self.output_dir = args.output or f"recon_{self.domain}_{datetime.now().strftime('%Y%m%d_%H%M%S')}"
        self.http = HTTPClient(timeout=args.timeout, rate_limit=args.rate_limit)
        self.data = {"target":self.domain,"scan_date":datetime.now().isoformat(),"scan_options":vars(args)}

    def run(self):
        Logger.banner()
        Logger.info(f"Target: {self.domain}")
        Logger.info(f"Output: {self.output_dir}")
        start = time.time()
        skip = self.args.skip or []

        modules = []
        if "whois" not in skip: modules.append(("WHOIS", lambda: self.data.update({"whois":WHOISLookup().lookup(self.domain)})))
        if "dns" not in skip: modules.append(("DNS", lambda: self.data.update({"dns_records":DNSIntelligence(self.domain).gather()})))
        if "subdomains" not in skip: modules.append(("Subdomains", lambda: self.data.update({"subdomains":list(SubdomainEnumerator(self.domain,self.http,self.args.wordlist).enumerate_all())})))
        if "ports" not in skip:
            def do_ports():
                ports = [int(p) for p in self.args.ports.split(",")] if self.args.ports else None
                self.data["open_ports"] = PortScanner(self.args.port_timeout).scan(self.domain, ports)
            modules.append(("Ports", do_ports))
        if "http" not in skip:
            def do_http():
                hosts = set(self.data.get("subdomains",[self.domain])); hosts.add(self.domain)
                self.data["live_hosts"] = HTTPProber(self.http).probe(hosts)
            modules.append(("HTTP", do_http))
        if "ssl" not in skip: modules.append(("SSL", lambda: self.data.update({"ssl":SSLAnalyzer().analyze(self.domain)})))
        if "headers" not in skip:
            def do_headers():
                r = self.http.get(f"https://{self.domain}")
                if r: self.data["security_headers"] = SecurityHeaderAnalyzer().analyze(dict(r.headers), f"https://{self.domain}")
            modules.append(("Headers", do_headers))
        if "wayback" not in skip: modules.append(("Wayback", lambda: self.data.update({"wayback":WaybackHarvester(self.domain,self.http).harvest()})))
        if "crawl" not in skip:
            def do_crawl():
                base = f"https://{self.domain}"
                if not self.http.get(base): base = f"http://{self.domain}"
                self.data["crawl"] = WebCrawler(self.http, self.args.crawl_depth, self.args.max_pages).crawl(base)
            modules.append(("Crawl", do_crawl))

        for name, fn in modules:
            try: fn()
            except KeyboardInterrupt: Logger.warning("Interrupted"); break
            except Exception as e: Logger.error(f"{name} failed: {e}")

        elapsed = time.time() - start
        self.data["duration_seconds"] = round(elapsed, 2)

        Logger.section("Reports")
        rpt = ReportGenerator(self.domain, self.output_dir)
        fmt = self.args.report_format
        if "json" in fmt or "all" in fmt: rpt.generate_json(self.data)
        if "html" in fmt or "all" in fmt: rpt.generate_html(self.data)
        if "csv" in fmt or "all" in fmt: rpt.generate_csv(self.data)

        Logger.section("Complete")
        Logger.success(f"Duration: {elapsed:.1f}s | Output: {self.output_dir}/")
        wb = self.data.get("wayback",{})
        cr = self.data.get("crawl",{})
        print(f"""
  {'─'*50}
  SUMMARY
  {'─'*50}
  Subdomains:    {len(self.data.get('subdomains',[]))}
  Live Hosts:    {len(self.data.get('live_hosts',[]))}
  Open Ports:    {len(self.data.get('open_ports',[]))}
  DNS Records:   {sum(len(v) for v in self.data.get('dns_records',{}).values())}
  Wayback URLs:  {len(wb.get('urls',[]))}
  Parameters:    {len(wb.get('parameters',[]))}
  JS Files:      {len(wb.get('js_files',[]))}
  Crawled:       {len(cr.get('endpoints',[]))}
  Forms:         {len(cr.get('forms',[]))}
  {'─'*50}
""")


def main():
    p = argparse.ArgumentParser(description="BugBountyRecon v2.0",
        formatter_class=argparse.RawDescriptionHelpFormatter,
        epilog="Examples:\n  %(prog)s -d example.com\n  %(prog)s -d example.com --skip ports crawl\n  %(prog)s -d example.com -f html json -o results\n\nFor authorized testing only.")
    p.add_argument("-d","--domain",required=True)
    p.add_argument("-o","--output")
    p.add_argument("-f","--report-format",nargs="+",default=["all"],choices=["json","html","csv","all"])
    p.add_argument("-w","--wordlist")
    p.add_argument("-p","--ports")
    p.add_argument("--timeout",type=int,default=10)
    p.add_argument("--port-timeout",type=float,default=1.5)
    p.add_argument("--rate-limit",type=float,default=0.1)
    p.add_argument("--crawl-depth",type=int,default=3)
    p.add_argument("--max-pages",type=int,default=100)
    p.add_argument("--skip",nargs="+",default=[],choices=["whois","dns","subdomains","ports","http","ssl","headers","wayback","crawl"])
    p.add_argument("--no-color",action="store_true")
    args = p.parse_args()
    if args.no_color: Colors.disable()
    if not HAVE_REQUESTS:
        print("ERROR: 'requests' is required. Install: pip install requests"); sys.exit(1)
    BugBountyRecon(args).run()

if __name__ == "__main__":
    main()

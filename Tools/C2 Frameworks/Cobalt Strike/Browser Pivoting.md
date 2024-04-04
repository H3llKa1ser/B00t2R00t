# Browser Pivoting

### Malware like Zeus and its variants inject themselves into a user’s browser to steal banking information. This is a man-in-the-browser attack. So-called, because the attacker is injecting malware into the target’s browser.

## Overview

### Man-in-the-browser malware uses two approaches to steal banking information. They either capture form data as it’s sent to a server. For example, malware might hook PR_Write in Firefox to intercept HTTP POST data sent by Firefox.Or, they inject JavaScript onto certain webpages to make the user think the site is requesting information that the attacker needs.

### Cobalt Strike offers a third approach for man-in-the-browser attacks. It lets the attacker hijack authenticated web sessions—all of them.Once a user logs onto a site, an attacker may ask the user’s browser to make requests on their behalf. Since the user’s browser is making the request, it will automatically re-authenticate to any site the user is already logged onto. I call this a browser pivot—because the attacker is pivoting their browser through the compromised user’s browser

### Cobalt Strike’s implementation of browser pivoting for Internet Explorer injects an HTTP proxy server into the compromised user’s browser. Do not confuse this with changing the user’s proxy settings. This proxy server does not affect how the user gets to a site. Rather, this proxy server is available to the attacker. All requests that come through it are fulfilled by the user’s browser.

## Setup

### To setup Browser pivoting, go to [beacon] -> Explore -> Browser Pivot. Choose the Internet Explorer instance that you want to inject into. You may also decide which port to bind the browser pivoting proxy server to as well.

### Beware that the process you inject into matters a great deal. Inject into Internet Explorer to inherit a user’s authenticated web sessions. Modern versions of Internet Explorer spawn each tab in its own process. If your target uses a modern version of Internet Explorer, you must inject a process associated with an open tab to inherit session state. Which tab process doesn’t matter (child tabs share session state).

### Identify Internet Explorer tab processes by looking at the PPID value in the Browser Pivoting setup dialog. If the PPID references explorer.exe, the process is not associated with a tab. If the PPID references iexplore.exe, the process is associated with a tab. Cobalt Strike will show a checkmark next to the processes it thinks you should inject into.

### Once Browser Pivoting is setup, set up your web browser to use the Browser Pivot Proxy server. Remember, Cobalt Strike’s Browser Pivot server is an HTTP proxy server.

## Use

### You may browse the web as your target user once browser pivoting is started. Beware that the browser pivoting proxy server will present its SSL certificate for SSL-enabled websites you visit. This is necessary for the technology to work.

### The browser pivoting proxy server will ask you to add a host to your browser’s trust store when it detects an SSL error. Add these hosts to the trust store and press refresh to make SSL protected sites load properly.

### If your browser pins the certificate of a target site, you may find its impossible to get your browser to accept the browser pivoting proxy server’s SSL certificate. This is a pain.One option is to use a different browser. The open source Chromium browser has a command-line option to ignore all certificate errors. This is ideal for browser pivoting use:

#### Command: chromium --ignore-certificate-errors --proxy-server=[host]:[port]

### The above command is available from View -> Proxy Pivots. Highlight the Browser Pivot HTTP Proxy entry and press Tunnel.

### To stop the Browser Pivot proxy server, type browserpivot stop in its Beacon console.

### You will need to reinject the browser pivot proxy server if the user closes the tab you’re working from. The Browser Pivot tab will warn you when it can’t connect to the browser pivot proxy server in the browser.

## How Browser Pivoting Works

### Internet Explorer delegates all of its communication to a library called WinINet. This library, which any program may use, manages cookies, SSL sessions, and server authentication for its consumers. Cobalt Strike’s Browser Pivoting takes advantage of the fact that WinINet transparently manages authentication and reauthentication on a per process basis.

### By injecting Cobalt Strike’s Browser Pivoting technology into a user’s Internet Explorer instance, you get this transparent reauthentication for free.


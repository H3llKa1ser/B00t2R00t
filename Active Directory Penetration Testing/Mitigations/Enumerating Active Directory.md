# MITIGATIONS

### 1) Sharphound generates a significant amount of Logon events when enumerating info. Since it executes from a single AD account, these Logon events will be associated with this single account. Write detection rules for this behavior.

#### 2) Write signature detection rules for AD-RSAT, sharphound, etc.

#### 3) Monitor for CMD/Powershell if not used by employees.

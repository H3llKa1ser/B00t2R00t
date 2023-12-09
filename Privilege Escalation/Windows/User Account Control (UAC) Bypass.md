# INTEGRITY LEVELS (IL)

### Low = Generally used for interaction with the Internet. Has very limited permissions.

### Medium = Assigned to standard users and Administrators' filtered tokens.

### High = Used by Administrators' elevated tokens if UAC is disabled. All administrators will always use a high IL token.

### System = Reserved for system use.

# FILTERED TOKENS

### Non-administrators: Will receive a single access token when logged in, which will be used for all tasks performed by the user. This token has Medium IL.

### Administrators: Filtered token = A token with Administrator privileges stripped, used for regular operations. This token has Medium IL.

### Elevated Token = Full admin privileges. High IL.

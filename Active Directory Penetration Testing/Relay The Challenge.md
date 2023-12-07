## Requirements:

#### 1) SMB Signing disabled or enabled but not enforced.

#### If SMB Signing is enabled, we won't be able to forge the message signature, meaning the server would reject it.

#### 2) The associated account needs relevant permissions on the server to access the requested resources.

#### 3) Since we technically don't have yet an AD foothold, some guesswork is involved, info what accounts will have permissions on which hosts.

# Types:

### 1: Blind command injection

### 2: Verbose command injection

## Payloads

### Windows:

#### 1: whoami

#### 2: dir

#### 3: timeout (alternative to ping)

#### 4: ping (blind)

### Linux:

#### 1: whoami

#### 2: ls

#### 3: ping (blind)

#### 4: sleep (alternate to ping)

#### 5: nc (reverse shell)

## Operators

#### ; & && | || >

## TIP:

#### We can use curl for testing blind command injection (URL Encoded)

## Vulnerable functions

### PHP:

#### exec()

#### passthru()

#### system()


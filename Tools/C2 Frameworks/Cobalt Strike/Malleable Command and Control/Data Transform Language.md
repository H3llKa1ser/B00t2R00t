# Data Transform Language

### A data transform is a sequence of statements that transform and transmit data. The data transform statements are:

#### 1) append "String", Action: append "string", Inverse: Remove last LEN("string") characters

#### 2) base64, Action: Base64 Encode, Inverse: Base64 Decode

#### 3) base64url, Action: URL-safe Base64 Encode, Inverse: URL-safe Base64 Decode

#### 4) mask, Action: XOR mask w/ random key, Inverse: XOR mask w/ random key

#### 5) netbios, Action: NetBIOS Encode 'a', Inverse: NetBIOS Decode 'a'

#### 6) netbiosu, Action: NetBIOS Encode 'A', Inverse: NetBIOS Decode 'A'

#### 7) prepend "string", Action: prepend "string", Inverse: Remove first LEN("string") characters

### A data transform is a combination of any number of these statements, in any order. For example, you may choose to netbios encode the data to transmit, prepend some information, and then base64 encode the whole package.

### A data transform always ends with a termination statement. You may only use one termination statement in a transform. This statement tells Beacon and its server where in the transaction to store the transformed data.

#### 1) header "header" -> Store data in an HTTP Header

#### 2) parameter "key" -> Store data in a URI parameter

#### 3) print -> Send data as transaction body

#### 4) uri-append -> Append to URI

### The header termination statement stores transformed data in an HTTP header. The parameter termination statement stores transformed data in an HTTP parameter. This parameter is always sent as part of URI. The print statement sends transformed data in the body of the transaction.

### The print statement is the expected termination statement for the http-get.server.output, httppost.server.output, and http-stager.server.output blocks. You may use the header, parameter, print and uri-append termination statements for the other blocks.

### If you use a header, parameter, or uri-append termination statement on http-post.client.output, Beacon will chunk its responses to a reasonable length to fit into this part of the transaction.

### These blocks and the data they send are described in a later section.

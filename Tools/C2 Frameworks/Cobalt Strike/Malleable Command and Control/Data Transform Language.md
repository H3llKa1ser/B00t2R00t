# Data Transform Language

### A data transform is a sequence of statements that transform and transmit data. The data transform statements are:

#### 1) append "String", Action: append "string", Inverse: Remove last LEN("string") characters

#### 2) base64, Action: Base64 Encode, Inverse: Base64 Decode

#### 3) base64url, Action: URL-safe Base64 Encode, Inverse: URL-safe Base64 Decode

#### 4) mask, Action: XOR mask w/ random key, Inverse: XOR mask w/ random key

#### 5) netbios, Action: NetBIOS Encode 'a', Inverse: NetBIOS Decode 'a'

#### 6) netbiosu, Action: NetBIOS Encode 'A', Inverse: NetBIOS Decode 'A'

#### 7) prepend "string", Action: prepend "string", Inverse: Remove first LEN("string") characters

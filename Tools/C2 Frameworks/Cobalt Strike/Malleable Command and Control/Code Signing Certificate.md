# Code Signing Certificate

### Payloads -> Windows Stager Payload and Windows Stageless Payload give you the option to sign an executable or DLL file. To use this option, you must specify a Java Keystore file with your code signing certificate and private key. Cobalt Strike expects to find the Java Keystore file in the same folder as your Malleable C2 profile.

code-signer {
set keystore "keystore.jks";
set password "password";
set alias    "server";
}

### The code signing certificate settings are:

#### 1) alias = The keystore’s alias for this certificate

#### 2) digest_algorithm = The digest algorithm

#### 3) keystore = Java Keystore file with certificate information (.jks extension)

#### 4) password = The password to your Java Keystore

#### 5) timestamp = Timestamp the file using a third-party service

#### 6) timestamp_url = URL of the timestamp service

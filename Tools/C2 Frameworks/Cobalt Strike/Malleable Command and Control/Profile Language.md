# Profile Language

### The best way to create a profile is to modify an existing one. Several example profiles are available on Github: https://github.com/cobalt-strike/Malleable-C2-Profiles

### When you open a profile, here is what you will see:

[#] this is a comment
set global_option "value";

protocol-transaction {
  set local_option "value";
  
  client {
      [#] customize client indicators
  }
 
  server {
      [#] customize server indicators
  }
}

### Comments begin with a #and go until the end of the line. The set statement is a way to assign a value to an option. Profiles use { curly braces } to group statements and information together. Statements always end with a semi-colon.

### To help all of this make sense, here’s a partial profile:

http-get {
        set uri "/foobar";
        client {
            metadata {
                      base64;
                      prepend "user=";
                      header "Cookie";
            }
    }

### This partial profile defines indicators for an HTTP GET transaction. The first statement, set uri, assigns the URI that the client and server will reference during this transaction. This set statement occurs outside of the client and server code blocks because it applies to both of them.

### The client block defines indicators for the client that performs an HTTP GET. The client, in this case, is Cobalt Strike’s Beacon payload.

### When Cobalt Strike’s Beacon “phones home”it sends metadata about itself to Cobalt Strike. In this profile, we have to define how this metadata is encoded and sent with our HTTP GET request.

### The metadata keyword followed by a group of statements specifies how to transform and embed metadata into our HTTP GET request. The group of statements, following the metadata keyword, is called a data transform.

## Steps:

#### 0) Start (metadata)

#### 1) base64, Action: Base64 Encode (bWV0YWRhdGE=)

#### 2) prepend "user=", Action: Prepend String (user=bWV0YWRhdGE=)

#### 3) header "Cookie", Action: Store in Transaction

### The first statement in our data transform states that we will base64 encode our metadata [1]. The second statement, prepend, takes our encoded metadata and prepends the string user= to it [2]. Now our transformed metadata is “user=“ . base64(metadata). The third statement states we will store our transformed metadata into a client HTTP header called Cookie [3]. That’s it.

### Both Beacon and its server consume profiles. Here, we’ve read the profile from the perspective of the Beacon client. The Beacon server will take this same information and interpret it backwards. Let’s say our Cobalt Strike web server receives a GET request to the URI /foobar. Now, it wants to extract metadata from the transaction.

## Steps:

#### 0) Start

#### 1) header "Cookie", Action: Recover from Transaction (user=bWV0YWRhdGE=)

#### 2) prepend "user=", Action: Remove first 5 characters (bWV0YWRhdGE=)

#### 3) base64, Action: Bse64 Decode (metadata)

### The header statement will tell our server where to recover our transformed metadata from [1]. The HTTP server takes care to parse headers from the HTTP client for us. Next, we need to deal with the prepend statement. To recover transformed data, we interpret prepend as remove the first X characters [2], where X is the length of the original string we prepended. Now, all that’s left is to interpret the last statement, base64. We used a base64 encode function to transform the metadata before. Now, we use a base64 decode to recover the metadata [3].

### We will have the original metadata once the profile interpreter finishes executing each of these inverse statements.



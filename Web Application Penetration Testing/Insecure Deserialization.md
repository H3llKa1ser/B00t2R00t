# Insecure Deserialization

## Identification

### White-Box Approach (Access to the source code)

#### Check for serialisation functions like:

 - 1) serialize()
   
 - 2) unserialize() 
  
 - 3) pickle.loads()
  
#### And others.

## TIP:  We must pay special attention to any point where user-supplied input might be passed directly to these functions.

### Black-Box Approach (No access to the source code)

#### 1) Analysing Server Responses

 - Error messages: Certain error messages can indirectly indicate issues with serialisation. For instance, PHP might throw errors or warnings that contain phrases like unserialize() or Object deserialisation error, which are giveaways of underlying serialisation processes and potential points of vulnerability.

 - Inconsistencies in application behaviour: Unexpected behaviour in response to manipulated input (e.g., modified cookies or POST data) can suggest issues with how data is deserialised and handled. Observing how the application handles altered serialised data can provide clues about potentially vulnerable code.

#### 2) Examining Cookies

### Cookies are often used to store serialised data in web applications. By examining the contents of cookies, one can usually infer:

 - Base64 encoded values in cookies (PHP and .NET): If cookies contain data that looks base64 encoded, decoding it might reveal serialised objects or data structures. PHP often uses serialisation for session management and storing session variables in serialised format.

 - ASP.NET view state: .NET applications might use serialisation in the view state sent to the client's browser. A field named __VIEWSTATE, which is base64 encoded, can sometimes be seen. Decoding and examining it can reveal whether it contains serialised data that could be exploited.

#### 3) Append a tilde (~) at the end of a PHP file

 - Append a tilde at the end of a PHP file to try to access backup or temporary files created by text editors or version control systems. When a file is edited or saved, some text editors or version control systems may make a backup copy of the original file with a tilde appended to the file name.

## Exploitation Techniques

### 1) Update Properties of an object

#### Storing User Data in Cookies:

 - When a user visits our application for the first time, it sets a serialised cookie containing their user data. This includes their user name, role, and subscription status (isSubscribed). If the user is a paid member (isSubscribed = true), they are allowed to share notes. (Example scenario)

#### Exploitation steps:

 - 1) Decode the serialised cookie from Base64
  
 - 2) Modify any values we may find valuable to elevate our privileges and/or bypassing access controls
  
 - 3) Encode the modified serialised cookie in Base54
  
 - 4) Paste our modified value in the cookie value WITHOUT refreshing the page for profit

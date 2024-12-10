    $ sed -i 's/from_ip := req.RemoteAddr/from_ip := req.Header.Get("CF-Connecting-IP")/' ./core/http_proxy.go
    $ sed -i 's/\(parts := strings.SplitN(req.RemoteAddr, ":", 2)\)/\/\/\1/' ./core/http_proxy.go
    $ sed -i 's/remote_addr := parts\[0\]/remote_addr := req.Header.Get("CF-Connecting-IP")/' ./core/http_proxy.go

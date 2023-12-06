for i in {1.65535}; do (echo > /dev/tcp/192.168.1.1/$i>> /dev/null 2>&1 && echo $i is open; done

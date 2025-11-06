# Swaks

## Github: https://github.com/jetmore/swaks

#### Send email

    swaks --to TARGET@MAIL.COM --from TARGET@MAIL.COM --header "Subject: WHATEVER" --body "WHATEVER" --server TARGET_IP --attach @MALICIOUS_FILE

#### Send email with authentication

    swaks -t <recipient@example.com> --from <sender@example.com> \
    --attach config.Library-ms --server <SMTP_SERVER> --body body.txt \
    --header "Subject: Problems" --suppress-data \
    --auth LOGIN --auth-user <username> --auth-password <password>

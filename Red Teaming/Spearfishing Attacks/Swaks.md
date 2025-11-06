# Swaks

## Github: https://github.com/jetmore/swaks

#### Send email

    swaks --to TARGET@MAIL.COM --from TARGET@MAIL.COM --header "Subject: WHATEVER" --body "WHATEVER" --server TARGET_IP --attach @MALICIOUS_FILE

#### Send email with authentication

    swaks -t <recipient@example.com> --from <sender@example.com> \ --attach config.Library-ms --server <SMTP_SERVER> --body body.txt \ --header "Subject: Problems" --suppress-data \ --auth LOGIN --auth-user <username> --auth-password <password>

#### Email with Custom Headers for Social Engineering

    swaks -t [target-email] --from [your-email] --attach [file-to-attach] \ --server [smtp-server-ip] --body [email-body.txt] \ --header "X Priority: 1 (Highest)" --header "Importance: High" --suppress-data

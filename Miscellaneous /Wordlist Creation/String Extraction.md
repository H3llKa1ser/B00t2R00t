# String Extraction

## From PDF files

### 1) Download any PDF file from the web server

    wget -r -A pdf http://domain.local/docs/

### 2) Extract human readable strings from PDF files

    for f in $(find domain.local/docs -name '*.pdf'); do strings -n 5 "$f" | grep -vP '^[/<>%0-9\\]|^(stream|endstream|endobj|xref|trailer|startxref)$' >> raw_words.txt; done

### 3) Extract emails from PDFs

    grep -RhiaoP '[A-Za-z0-9._%+-]+@domain\.com' domain.local/docs > emails_docs.txt

Remove duplicate email addresses

    sort -u emails_docs.txt > emails_docs.unique.txt

Form a username list

    grep -Po '^[^@]+' emails_docs.unique.txt > users_from_emails.txt


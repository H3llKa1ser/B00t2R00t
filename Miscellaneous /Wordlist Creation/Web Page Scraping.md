# Web Page Scraping

## Cewl

Link: https://github.com/digininja/CeWL

### 1) Generate keyword wordlist and email list

    cewl -d 2 -m 3 --lowercase --with-numbers -e --email_file emails.txt -w cewl_words.txt http://domain.local

## Harvest names from the social page

### 1) Extract names

    curl -s http://social.tryfinanceme.local/ | grep -Po '(?<=<h3 class="profile-name">)[^<]+' > names.txt

### 2) Transform downloaded names list into likely username patterns

first.last

    awk '{print tolower($1)"."tolower($2)}' names.txt > users_first.last.txt

flast

    awk '{print tolower(substr($1,1,1))tolower($2)}' names.txt > users_flast.txt

firstl

    awk '{print tolower($1)tolower(substr($2,1,1))}' names.txt > users_firstl.txt


# Cleaning Wordlists

After creating our wordlists by gathering and extracting information, we should then create a cleaner wordlist that is more effective for our attacks.

### 1) Merging and normalizing password words

Take 2 wordlists, then merge them into one, removing duplicate entries

    cat cewl_words.txt raw_words.txt | sort -u > words_raw.txt

Convert uppercase to lowercase, strip Windows carriage returns, keep strings that start with an alphanumeric letter, allow letters, digits, dots, underscores or dashes, and are at least five characters long, then finally ensure further uniqueness.

    cat words_raw.txt | tr '[:upper:]' '[:lower:]' | tr -d '\r' | grep -P '^[a-z0-9][a-z0-9._-]{4,}$' | sort -u > words_clean.txt

Check size and contents

    wc -l words_clean.txt
    head words_clean.txt

### 2) Merging and normalizing usernames

Merge all variations and remove duplicates

    cat users_first.last.txt users_flast.txt users_firstl.txt users_from_emails.txt | sort -u > users.txt

### 3) Pattern-Based password list

Generate a wordlist that has minimum and maximum length to 11 characters. The percentages are replaced by digits (00 through 99), then write 100 entries to disk.

    crunch 11 11 -t Example20%%! -o pass_example.txt

#### TIP: If you discover later that passwords follow a different format, adjust the pattern accordingly (e.g., a different year or more digits)


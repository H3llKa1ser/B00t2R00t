# MUATION RULES

### Border Mutation = Commonly used combinations of digits and special symbols can be added at the end or at the beginning or both

### Freak Mutation = Letters are replaced with similarly looking symbols

### Case Mutation = The program checks all variations of uppercase/lowercase letters for any character

### Order Mutation = Character order is reused

### Repetition Mutation = The same group of characters are reported several times

### Vowels Mutation = Vowels are omitted or capitalized

### Strip Mutation = One or several characters are removed

### Swap Mutation = Some characters are swapped and change places

### Duplicate Mutation = Some characters are duplicated

### Delimiter Mutation = Delimiters are added between charactes

## TIP: You can combine several mutations together

## Password Mutations

| **Command**| **Description**|
|-|-|
| `cewl https://www.inlanefreight.com -d 4 -m 6 --lowercase -w inlane.wordlist` | Uses cewl to generate a wordlist based on keywords present on a website. |
| `hashcat --force password.list -r custom.rule --stdout > mut_password.list` | Uses Hashcat to generate a rule-based word list.             |
| `./username-anarchy -i /path/to/listoffirstandlastnames.txt` | Users username-anarchy tool in conjunction with a pre-made list of first and last names to generate a list of potential username. |
| `curl -s https://fileinfo.com/filetypes/compressed \| html2text \| awk '{print tolower($1)}' \| grep "\." \| tee -a compressed_ext.txt` | Uses Linux-based commands curl, awk, grep and tee to download a list of file extensions to be used in searching for files that could contain passwords. |


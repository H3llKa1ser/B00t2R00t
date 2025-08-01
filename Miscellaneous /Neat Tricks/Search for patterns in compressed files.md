# Search for patterns within compressed files

## Tool: zgrep

### Usage: (Search for a specific string against all of the comrpessed files within the directory. This is used when we dump an entire docker registry repository and we try to search for content within the blobs)

    zgrep -la STRING *.tar.gz 

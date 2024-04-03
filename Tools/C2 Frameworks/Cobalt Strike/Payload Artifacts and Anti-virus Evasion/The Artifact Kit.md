# The Artifact Kit

### Cobalt Strike uses the Artifact Kit to generate its executables and DLLs. The Artifact Kit is part of the Arsenal Kit, which contains a collection of kits—a source code framework to build executables and DLLs that evade some anti-virus products.

## The theory of the Artifact Kit

### Traditional anti-virus products use signatures to identify known bad. If we embed our known bad shellcode into an executable, an anti-virus product will recognize the shellcode and flag the executable as malicious.

### To defeat this detection, it’s common for an attacker to obfuscate the shellcode in some way and place it in the binary. This obfuscation process defeats anti-virus products that use a simple string search to identify malicious code.

### Many anti-virus products go a step further. These anti-virus products simulate execution of an executable in a virtual sandbox. With each emulated step of execution, the anti-virus product checks for known bad in the emulated process space. If known bad shows up, the anti-virus product flags the executable or DLL as malicious. This technique defeats many encoders and packers that try to hide known bad from signature-based anti-virus products.

### Cobalt Strike’s counter to this is simple. The anti-virus sandbox has limitations. It is not a complete virtual machine. There are system behaviors the anti-virus sandbox does not emulate.

### The Artifact Kit is a collection of executable and DLL templates that rely on some behavior that anti-virus product’s do not emulate to recover shellcode located inside of the binary.

### One of the techniques [see: src-common/bypass-pipe.c in the Artifact Kit] generates executables and DLLs that serve shellcode to themselves over a named pipe. If an anti-virus sandbox does not emulate named pipes, it will not find the known bad shellcode.

## Where Artifact Kit fails

### Of course it’s possible for anti-virus products to defeat specific implementations of the Artifact Kit. If an anti-virus vendor writes signatures for the Artifact Kit technique you use, then the executables and DLLs it creates will get caught. This started to happen, over time, with the default bypass technique in Cobalt Strike 2.5 and below. If you want to get the most from the Artifact Kit, you will use one of its techniques as a base to build your own Artifact Kit implementation.

### Even that isn’t enough though. Some anti-virus products call home to the anti-virus vendor’s servers. There the vendor makes a determination if the executable or DLL is known good or an unknown, never before seen, executable or DLL. Some of these products automatically send unknown executables and DLLs to the vendor for further analysis and warn the users.Others treat unknown executables and DLLs as malicious. It depends on the product and its settings.

### The point: no amount of “obfuscation”is going to help you in this situation. You’re up against a different kind of defense and will need to work around it accordingly. Treat these situations the same way you would treat application whitelisting. Try to find a known good program (e.g., powershell) that will get your payload stager into memory.

## How to use the Artifact Kit

### Go to Help -> Arsenal from a licensed Cobalt Strike to download the Arsenal Kit. You can also access the Arsenal directly at: https://www.cobaltstrike.com/scripts

### Fortra distributes the Arsenal Kit as a .tgz file. Use the tar command to extract it. The Arsenal Kit includes the Artifact kit, which can be built with other kits or as a stand alone kit. See the Arsenal Kit README.md file for information on building the kits.

### You’re encouraged to modify the Artifact Kit and its techniques to make it meet your needs. While skilled C programmers can do more with the Artifact Kit, it’s quite feasible for an adventurous non-programmer to work with the Artifact Kit too. For example, a major anti-virus product likes to write signatures for the executables in Cobalt Strike’s trial each time there is a release. Up until Cobalt Strike 2.5, the trial and licensed versions of Cobalt Strike used the named pipe technique in its executables and DLLs. This vendor would write a signature for the named pipe string the executable used. Defeating their signatures, release after release, was as simple as changing the name of the pipe in the pipe technique’s source code.


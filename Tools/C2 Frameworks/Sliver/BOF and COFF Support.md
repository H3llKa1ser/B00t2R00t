# BOF and COFF Support

### Sliver v1.5 and later support the loading and execution of BOFs and COFFs, generally no code changes are needed to use BOFs with a Sliver implant. However, you may need to define a manifest file so that Sliver is aware of BOF arguments and their types.

# BOF Extensions

### BOF support is provided via the COFF Loader extension, you'll need it installed to run pretty much any BOF. However, the COFF Loader will be installed automatically if you install a BOF extension from the armory.

### The easiest way to install a BOF extension, for example nanodump, is using the armory package manager:

#### armory install nanodump

## IMPORTANT: BOF Extensions are installed per-sliver client, they are not stored on the server. Thus extensions are not shared across operators, each operator must install the extension to use it.

# Converting BOFs to Sliver

### Converting existing BOFs to work with Sliver is usually pretty easy, and shouldn't require any code changes. You'll need to define an extension.json though based on what arguments/etc. the BOF accepts.

### To determine the arguments a BOF accepts and their types, you'll need to read .cna script that accompanies a given BOF.

### Once the manifest is defined load it into your client using extensions load, locally loaded extensions do not need to be cryptographically signed. The paths in the manifest should be relative to the manifest file, parent directories are not allowed.

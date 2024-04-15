# Armory

## Github repo: https://github.com/sliverarmory

### The armory is the Sliver Alias and Extension package manager (introduced in Sliver v1.5), it allows you to automatically install various 3rd party tools such as BOFs and .NET tooling.

### The armory downloads packages from github.com and api.github.com so you'll need an internet connection in order for the command to work. The command does support proxies (see --help) and after an alias or extension is installed an internet connection is not required to execute the alias/extension.

### Aliases and extensions are installed on the "sliver client"-side, and thus are not shared among operators in multiplayer mode.

### As of v1.5.14 you can also use armory install all to install everything if you really want to.

# The Official Armory

### The official armory ships with Sliver binaries and is included by default in the Makefile when compiling from source. You can interact with the Armory using the armory command. Packages installed from the official armory are compiled and cryptographically signed by the Sliver authors. While we make a best effort to review 3rd party code, you are responsible for reviewing and understanding any 3rd party code before using it. Source code for any alias or extension can be found under the Sliver Armory GitHub organization.

## Installing Packages

### List available packages by running the armory command without arguments, packages are installed using the package's command name:

#### Example: armory install rubeus

## Updating Packages

### You can update all installed aliases and extensions by running armory update command.

## Removing Packages

### You remove packages installed from the armory using the aliases rm and extensions rm commands depending on if the package is an alias or an extension. You can list installed aliases and extensions by running aliases and extensions respectfully.

### Installed alias and extension files are stored in ~/.sliver-client/ by default if you want to manually remove a package simply delete its corresponding directory and restart the client.


# Embedded OLE + LNK objects 

Attackers embed .lnk files into the Office documents and camouflage them with Ms Word office icons in order to deceive victims to click and run them. 

## Weaponization

### 1) Create a .lnk file by running the powershell script (script in this repo)

    .\ole.ps1

Powershell script will trigger a rudimentary NC reverse shell for example

### 2) Create a word document that will contain the malicious shortcut that we created previously

Let's insert a new object into the document by selecting a Packageand changing its icon source to a Microsoft Word executable:

Point the package to the .lnk file containing the payload:

### 3) Victim executes the payload and GG!

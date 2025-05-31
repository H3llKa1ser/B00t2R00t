# Inject Macros from a Remote Dotm Template

It is possible to add a macros payload to a docx file indirectly, which has a good chance of evading some AVs/EDRs. 

## Steps

1) A malicious macro is saved in a Word template .dotm file

2) Benign .docx file is created based on one of the default MS Word Document templates

3) Document from step 2 is saved as .docx

4) Document from step 3 is renamed to .zip

5) Document from step 4 gets unzipped

6) .\word_rels\settings.xml.rels contains a reference to the template file. That reference gets replaced with a refernce to our malicious macro created in step 1. File can be hosted on a web server (http) or webdav (smb).

7) File gets zipped back up again and renamed to .docx

8) Done

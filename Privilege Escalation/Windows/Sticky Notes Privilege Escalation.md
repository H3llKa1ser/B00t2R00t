# Sticky Notes Privilege Escalation

Stored credentials might be found inside a DB file of the Sticky Notes application.

### 1) Sticky Notes Application Location

    %LocalAppData%\Packages\Microsoft.MicrosoftStickyNotes_8wekyb3d8bbwe\LocalState

### 2) Check the contents of the DB file

    type plum.sqlite

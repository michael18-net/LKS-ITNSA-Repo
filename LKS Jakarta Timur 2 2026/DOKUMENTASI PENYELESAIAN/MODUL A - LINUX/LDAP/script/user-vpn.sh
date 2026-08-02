#!/bin/bash

DOMAIN="dc=lksjakarta,dc=id"
PASSWORD="{SSHA}ytDAvMCvfz7fTgRBbvVEqKAy51/zTMTL"
OUTFILE="/root/ldap-lksjkt/ldif-files/vpn.ldif"

> "$OUTFILE"

for i in {1..3}; do
cat << EOF >> "$OUTFILE"
dn: uid=vpn$i,ou=vpn,$DOMAIN
objectClass: inetOrgPerson
objectClass: posixAccount
objectClass: shadowAccount
cn: vpn$i
sn: vpn$i
uid: vpn$i
uidNumber: $((13000+$i))
gidNumber: $((13000+$i))
homeDirectory: /home/vpn$i
loginshell: /bin/bash
userPassword: $PASSWORD

EOF
done

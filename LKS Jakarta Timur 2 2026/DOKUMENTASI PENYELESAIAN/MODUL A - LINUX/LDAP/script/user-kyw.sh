#!/bin/bash

DOMAIN="dc=lksjakarta,dc=id"
PASSWORD="{SSHA}ytDAvMCvfz7fTgRBbvVEqKAy51/zTMTL"
OUTFILE="/root/ldap-lksjkt/ldif-files/kyw.ldif"

> "$OUTFILE"

for i in {1..10}; do
cat << EOF >> "$OUTFILE"
dn: uid=kyw$i,ou=mail,$DOMAIN
objectClass: inetOrgPerson
objectClass: posixAccount
objectClass: shadowAccount
cn: kyw$i
sn: kyw$i
uid: kyw$i
uidNumber: $((12000+$i))
gidNumber: $((12000+$i))
homeDirectory: /home/kyw$i
loginshell: /bin/bash
mail: kyw$i@lksjakarta.id
userPassword: $PASSWORD

EOF
done

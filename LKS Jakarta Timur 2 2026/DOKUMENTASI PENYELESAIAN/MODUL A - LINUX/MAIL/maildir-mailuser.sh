#!/bin/bash

for u in jago kyw1 kyw2 kyw3 kyw4 kyw5 kyw6 kyw7 kyw8 kyw9 kyw10; do
	mkdir -p /var/mail/vhosts/lksjakarta.id/$u/{cur,new,tmp}
	chown -R vmail:vmail /var/mail/vhosts/lksjakarta.id/$u
done

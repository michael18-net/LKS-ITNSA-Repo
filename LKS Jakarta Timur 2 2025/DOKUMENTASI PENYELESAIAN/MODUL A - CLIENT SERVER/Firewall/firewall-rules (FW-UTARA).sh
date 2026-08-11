#!/bin/bash

#Flush old rules
iptables -F
iptables -t nat -F
iptables -X

#Default Deny
iptables -P INPUT DROP
iptables -P FORWARD DROP
iptables -P OUTPUT ACCEPT

#INPUT Rules
iptables -A INPUT -p icmp -j ACCEPT
iptables -A INPUT -p tcp --dport 22 -j ACCEPT
iptables -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
iptables -A INPUT -p udp --dport 53 -j ACCEPT
iptables -A INPUT -p tcp --dport 53 -j ACCEPT
iptables -A INPUT -p tcp --dport 80 -j ACCEPT
iptables -A INPUT -p tcp --dport 443 -j ACCEPT

#FORWARD Rules
iptables -A FORWARD -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
iptables -A FORWARD -i ens32 -s 192.168.10.0/24 -o ens33 -j ACCEPT
iptables -A FORWARD -d 192.168.10.11 -p udp --dport 53 -j ACCEPT
iptables -A FORWARD -d 192.168.10.11 -p tcp --dport 53 -j ACCEPT

#NAT Prerouting
iptables -t nat -A PREROUTING -i ens33 -d 103.10.70.110 -p udp --dport 53 -j DNAT --to-destination 192.168.10.11:53
iptables -t nat -A PREROUTING -i ens33 -d 103.10.70.110 -p tcp --dport 53 -j DNAT --to-destination 192.168.10.11:53

#NAT Postrouting
iptables -t nat -A POSTROUTING -o ens33 -j MASQUERADE

#!/bin/bash

iptables -F
iptables -t nat -F
iptables -X

iptables -P INPUT DROP
iptables -P FORWARD DROP
iptables -P OUTPUT ACCEPT

iptables -A INPUT -i lo -j ACCEPT
iptables -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
iptables -A FORWARD -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
iptables -A INPUT -p icmp --icmp-type echo-request -m conntrack --ctstate NEW -j ACCEPT
iptables -A INPUT -p tcp --dport 22 -m conntrack --ctstate NEW -j ACCEPT
iptables -A INPUT -p tcp --dport 80 -m conntrack --ctstate NEW -j ACCEPT
iptables -A INPUT -p tcp --dport 443 -m conntrack --ctstate NEW -j ACCEPT

iptables -t nat -A POSTROUTING -s 192.168.10.0/24 -o ens32 -j MASQUERADE
iptables -t nat -A PREROUTING -i ens32 -d 103.10.70.110 -p udp --dport 53 -j DNAT --to-destination 192.168.10.11:53
iptables -t nat -A PREROUTING -i ens32 -d 103.10.70.110 -p tcp --dport 53 -j DNAT --to-destination 192.168.10.11:53

iptables -A FORWARD -p udp -d 192.168.10.11 --dport 53 -m conntrack --ctstate NEW -j ACCEPT
iptables -A FORWARD -p tcp -d 192.168.10.11 --dport 53 -m conntrack --ctstate NEW -j ACCEPT

iptables -A FORWARD -i ens33 -o ens32 -m conntrack --ctstate NEW -j ACCEPT

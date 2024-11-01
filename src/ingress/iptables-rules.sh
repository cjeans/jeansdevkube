#!/bin/bash

# Flush existing rules
iptables -F

# Allow traffic from the main network to the cluster network
iptables -A FORWARD -s 192.168.254.0/24 -d 10.1.189.0/24 -j ACCEPT

# Allow traffic from the cluster network to the main network
iptables -A FORWARD -s 10.1.189.0/24 -d 192.168.254.0/24 -j ACCEPT

# Enable NAT for traffic from the main network to the cluster network
iptables -t nat -A POSTROUTING -s 192.168.254.0/24 -d 10.1.189.0/24 -j MASQUERADE

# Enable NAT for traffic from the cluster network to the main network
iptables -t nat -A POSTROUTING -s 10.1.189.0/24 -d 192.168.254.0/24 -j MASQUERADE
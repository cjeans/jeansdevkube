#!/bin/bash

# Copy the network configuration file to the netplan directory
sudo cp /src/host-network/01-netcfg.yaml /etc/netplan/
# Apply the network configuration
sudo netplan apply
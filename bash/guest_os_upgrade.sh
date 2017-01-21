#!/bin/bash

# Update the package lists
sudo apt-get update

# Upgrade grub-pc, bypasssing interactive configuration that would otherwise halt provisioning
sudo DEBIAN_FRONTEND=noninteractive apt-get -y -o DPkg::options::="--force-confdef" -o DPkg::options::="--force-confold"  install grub-pc

# Upgrade all other packages
#   -y automatically accepts prompts
sudo apt-get upgrade -y

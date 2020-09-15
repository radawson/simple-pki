#!/bin/bash
# Basic script for setting up Simple PKI

# Download starter configs
echo -e "\nDownloading files..."
ca-config-dl.sh

# Create root CA
echo -e "\nCreating Root CA"
sudo ca-create-rootca.sh

# Create Signing CA
echo -e "\nCreating Signing CA"
sudo ca-create-signingca.sh
	

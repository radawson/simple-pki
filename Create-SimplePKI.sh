#!/bin/bash
# Basic script for setting up Simple PKI

# Download starter configs
git clone https://github.com/rdbh/simple-pki.git
cd simple-pki

# Create root CA
echo -e "Creating Root CA"
sudo ca-create-rootca.sh

# Create Signing CA
echo -e "Creating Signing CA"
sudo ca-create-signingca.sh
	

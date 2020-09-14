#!/bin/bash
# Basic script for setting up Simple PKI

# Create working directories
echo -e "Creating Signing CA Directories"
mkdir -p ca/signing-ca/private ca/signing-ca/db crl certs
chmod 700 ca/signing-ca/private

# Create database files
# NOTE: This will delete any previous directories
echo -e "Creating Database Files"
cp /dev/null ca/signing-ca/db/signing-ca.db
cp /dev/null ca/signing-ca/db/signing-ca.db.attr

# Start the certificate and CRL count at 1
echo 01 > ca/signing-ca/db/signing-ca.crt.srl
echo 01 > ca/signing-ca/db/signing-ca.crl.srl

# Open the Signing CA configuration
sudo nano etc/signing-ca.conf

# Create the signing CA
# The openssl req command takes its configuration from the [req] section of the root-ca.conf file.
# You will be asked for a passphrase to protect the private key.
cs-new-signing.sh signing-ca
	

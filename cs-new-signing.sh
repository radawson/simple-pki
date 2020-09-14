#!/bin/bash
# Basic script for setting up Simple PKI

# Check command line input
if [[ $1 =~ ^[0-9a-zA-Z_-]+$ ]];then

	# Create the CA request
	# The openssl req command takes its configuration from the [req] section of the signing-ca.conf file.
	# You will be asked for a passphrase to protect the private key.
	echo -e "Creating the signing CA request"
	openssl req -new \
		-config etc/signing-ca.conf \
		-out ca/signing-ca.csr \
		-keyout ca/signing-ca/private/signing-ca.key
	echo -e "Your private key is located at etc/certs/"$1".key"
	
	# Create the Email certificate
	# The openssl ca command takes its configuration from the [ca] section of the signing-ca.conf file.
	echo -e "Creating the signing CA certificate"
	openssl ca \
		-config etc/root-ca.conf \
		-in ca/signing-ca.csr \
		-out ca/signing-ca.crt \
		-extensions signing_ca_ext	
	echo -e "Your certificate is located at etc/certs/"$1".crt"
	exit
else
	echo -e "Invalid certificate name"
	exit
fi
	

#!/bin/bash
# Basic script for setting up Simple PKI

# Check command line input
if [[ $1 =~ ^[0-9a-zA-Z_-]+$ ]];then

	# Create the CS request
	# The openssl req command takes its configuration from the [req] section of the root-ca.conf file.
	# You will be asked for a passphrase to protect the private key.
	echo -e "Creating the Email request"
	openssl req -new \
		-config etc/email.conf \
		-out certs/$1.csr \
		-keyout certs/$1.key
	echo -e "Your private key is located at etc/certs/"$1".key"
	
	# Create the Email certificate
	# The openssl ca command takes its configuration from the [ca] section of the root-ca.conf file.
	echo -e "Creating the Email certificate"
	openssl ca \
		-config etc/signing-ca.conf \
		-in certs/$1.csr \
		-out certs/$1.crt \
		-extensions email_ext	
	echo -e "Your certificate is located at etc/certs/"$1".crt"
	exit
else
	echo -e "Invalid certificate name"
	exit
fi
	

#!/bin/bash
# Basic script for setting up Simple PKI

# Check command line input
if [[ $1 =~ ^[0-9a-zA-Z_-]+$ ]];then

	# Create the CS request
	# The openssl req command takes its configuration from the [req] section of the server.conf file.
	# Server Certificates generally don't have a passphrase.
	# SAN is an environmental variable for subjectAltName
	echo -e "\nCreating the Email request"
	SAN=DNS:www.$1 \
	openssl req -new \
		-config etc/server.conf \
		-out certs/$1.csr \
		-keyout certs/$1.key
	echo -e "Your private key is located at etc/certs/"$1".key"
	
	# Create the Email certificate
	# The openssl ca command takes its configuration from the [ca] section of the server.conf file.
	echo -e "\nCreating the Email certificate"
	openssl ca \
		-config etc/signing-ca.conf \
		-in certs/$1.csr \
		-out certs/$1.crt \
		-extensions server_ext	
	echo -e "Your certificate is located at etc/certs/"$1".crt"
	exit
else
	echo -e "\n\nInvalid certificate name"
	exit
fi
	

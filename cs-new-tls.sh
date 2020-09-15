#!/bin/bash
# Basic script for setting up Simple PKI

# Check command line input
if [ -z "$1" ];then
	echo -e "\n\nYou must specify a certificate name"
	exit 1
elif [[ $1 =~ ^[0-9a-zA-Z_-]+$ ]];then
	NAME=$1	
else
	echo -e "\n\nInvalid certificate name"
	exit 1
fi

# Create the CS request
# The openssl req command takes its configuration from the [req] section of the server.conf file.
# Server Certificates generally don't have a passphrase.
# SAN is an environmental variable for subjectAltName
echo -e "\nCreating the Email request"
SAN=DNS:www.$NAME \
openssl req -new \
	-config etc/server.conf \
	-out certs/$NAME.csr \
	-keyout certs/$NAME.key
echo -e "Your private key is located at etc/certs/"$NAME".key"

# Create the Email certificate
# The openssl ca command takes its configuration from the [ca] section of the server.conf file.
echo -e "\nCreating the Email certificate"
openssl ca \
	-config etc/signing-ca.conf \
	-in certs/$NAME.csr \
	-out certs/$NAME.crt \
	-extensions server_ext	
echo -e "Your certificate is located at etc/certs/"$NAME".crt"
exit

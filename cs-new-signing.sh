#!/bin/bash
# Basic script for setting up Simple PKI

# Check command line input
if [ -z "$1" ];then
	NAME="signing-ca"
elif [[ $1 =~ ^[0-9a-zA-Z_-]+$ ]];then
	NAME=$1	
else
	echo -e "\n\nInvalid certificate name"
	exit
fi

# Create the CA request
# The openssl req command takes its configuration from the [req] section of the signing-ca.conf file.
# You will be asked for a passphrase to protect the private key.
echo -e "Creating the signing CA request"
openssl req -new \
	-config etc/signing-ca.conf \
	-out ca/$NAME.csr \
	-keyout ca/signing-ca/private/$NAME.key
echo -e "Your private key is located at etc/certs/"$NAME".key"

# Create the Email certificate
# The openssl ca command takes its configuration from the [ca] section of the signing-ca.conf file.
echo -e "Creating the signing CA certificate"
openssl ca \
	-config etc/root-ca.conf \
	-in ca/$NAME.csr \
	-out ca/$NAME.crt \
	-extensions signing_ca_ext	
echo -e "Your certificate is located at etc/certs/"$NAME".crt"

	

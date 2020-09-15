#!/bin/bash
# Basic script for setting up Simple PKI

# Check command line input
if [ -z "$1" ];then
	echo -e "\n\nYou must specify a certificate name"
	exit 1
elif [[ $1 =~ ^[0-9]+$ ]];then
	NAME=$1	
else
	echo -e "\n\nInvalid certificate name."
	exit 1
fi

# Export the certificate
echo -e "Creating the "$NAME".cer"
openssl x509 \
	-in certs/$NAME.crt \
	-out certs/$NAME.cer \
	-outform der
echo -e "Certificate "$NAME".cer has been exported to certs/."
	

#!/bin/bash
# Basic script for setting up Simple PKI

if [ -z "$1" ];then
	NAME="signing-ca"
fi

# Check command line input
if [[ $1 =~ ^[0-9a-zA-Z_-]+$ ]];then
	NAME=$1
else
	echo -e "\n\nInvalid CA name"
	exit 1
fi

# Create the CS request

openssl ca -gencrl\
	-config etc/signing-ca.conf \
	-out crl/$NAME.crl
echo -e "\nYour certificate revocation list is located at crl/"$NAME".crl"


	

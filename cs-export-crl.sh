#!/bin/bash
# Basic script for setting up Simple PKI

# Check command line input
if [ -z "$1" ];then
	NAME="signing-ca"
elif [[ $1 =~ ^[0-9a-zA-Z_-]+$ ]];then
	NAME=$1	
else
	echo -e "\n\nInvalid certificate name"
	exit 1
fi

# Export the certificate revocation list
echo -e "Exporting the "$NAME" Certificate Revocation List(CRL)"
openssl crl \
	-in crl/$NAME.crl \
	-out certs/$NAME.crl \
	-outform der
echo -e $NAME" CRL has been exported to certs/."
	

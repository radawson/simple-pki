#!/bin/bash
# Basic script for setting up Simple PKI
# When revoking a certificate, you must do it by certificate number.


# Check command line input
if [ -z "$1" ];then
	echo -e "\n\nYou must specify a certificate number"
	exit 1
elif [[ $1 =~ ^[0-9]+$ ]];then
	NAME=$1	
else
	echo -e "\n\nYou must specify a certificate number.\nJust the number, nothing else."
	exit 1
fi

# REvoke the certificate
# The openssl req command takes its configuration from the [req] section of the email.conf file.
# You will be asked for a passphrase to protect the private key.
echo -e "Creating the Email request"
openssl ca \
	-config etc/signing-ca.conf \
	-revoke ca/signing-ca/$NAME.pem \
	-crl_reason $REASON
echo -e "Certificate number "$NAME" has been revoked."
	

#!/bin/bash

# installation
# set -a
# . ./homekube.env.sh
# set +a

HOMEKUBE_PUBLIC_IPS=10.1.189.200-10.1.189.201 # public entry points for metallb load balancer
HOMEKUBE_DOMAIN=jeansdev.org  # the public domain of this site

# Settings for NFS server
HOMEKUBE_NFS_SERVER_URL=192.168.254.130 # e.g. 192.168.1.250  # The url of the nfs server
HOMEKUBE_NFS_SERVER_PATH=/homes # The path to your data on the nfs server

# Settings for cert-manager
HOMEKUBE_DOMAIN_DASHED=${HOMEKUBE_DOMAIN//./-}  # required for cert-manager
HOMEKUBE_CERT_URL=https://auth.acme-dns.io # required for cert-manager

# Settings for postgres database
#HOMEKUBE_PG_USER=admin
HOMEKUBE_PG_PASSWORD=jeansdev123

# Settings for SSO / Keycloak
HOMEKUBE_KEYCLOAK_PASSWORD=jeansdev123
HOMEKUBE_OIDC_ISSUER=https://keycloak.jeansdev.org/realms/jeansdevkube
HOMEKUBE_OIDC_CLIENT_ID=jeansdevkube-client
# copy the client secret from keycloaks client creation form
HOMEKUBE_OAUTH2_CLIENT_SECRET=copy_secret_from_keycloaks_client_creation
# create a random secret: dd if=/dev/urandom bs=32 count=1 2>/dev/null | base64 | tr -d -- '\n' | tr -- '+/' '-_' ; echo
HOMEKUBE_OAUTH2_COOKIE_SECRET=create_random_secret

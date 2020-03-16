# LDAP auth source

NEXUS_CREDENTIALS=admin:admin123
NEXUS_ADDRESS=https://nexus.lab.example.com
SEARCH_BASE=dc=main,dc=dev
LDAP_PASSWORD=changeme1

curl -X POST \
  "http://$NEXUS_CREDENTIALS@$NEXUS_ADDRESS/service/rest/beta/security/ldap" \
  -H  "accept: application/json" \
  -H  "Content-Type: application/json" \
  -w "%{http_code}" \
  -d '{
    "name": "ldap",
    "protocol": "LDAP",
    "useTrustStore": false,
    "host": "ldap-openldap.ldap.svc.cluster.local",
    "port": 389,
    "searchBase": "'$SEARCH_BASE'",
    "authScheme": "SIMPLE",
    "authRealm": null,
    "authUsername": "cn=admin,'$SEARCH_BASE'",
    "authPassword": "'$LDAP_PASSWORD'",
    "connectionTimeoutSeconds": 30,
    "connectionRetryDelaySeconds": 300,
    "maxIncidentsCount": 3,
    "userBaseDn": "ou=people",
    "userSubtree": false,
    "userObjectClass": "inetOrgPerson",
    "userLdapFilter": "",
    "userIdAttribute": "uid",
    "userRealNameAttribute": "cn",
    "userEmailAddressAttribute": "mail",
    "userPasswordAttribute": "",
    "ldapGroupsAsRoles": true,
    "groupType": "DYNAMIC",
    "groupBaseDn": null,
    "groupSubtree": false,
    "groupObjectClass": null,
    "groupIdAttribute": null,
    "groupMemberAttribute": null,
    "groupMemberFormat": null,
    "userMemberOfAttribute": "memberOf"
  }'

# Mapping role
curl -X POST \
  "http://$NEXUS_CREDENTIALS@$NEXUS_ADDRESS/service/rest/beta/security/roles" \
  -H  "accept: application/json" \
  -H  "Content-Type: application/json" \
  -d '{
    "id": "superusers",
    "source": "default",
    "name": "superuser",
    "description": "",
    "privileges": [],
    "roles": [
      "nx-admin",
      "nx-anonymous"
    ]
  }'


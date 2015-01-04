#!/bin/sh
MYDIR="$( dirname $0 )"
MYPATH="$( realpath ${MYDIR} )"

. /etc/rc.conf
workdir="${cbsd_workdir}"
. ${workdir}/cbsd.conf

[ -f "${MYPATH}/forms.sqlite" ] && rm -f "${MYPATH}/forms.sqlite"

/usr/local/bin/cbsd ${miscdir}/updatesql ${MYPATH}/forms.sqlite /usr/local/cbsd/share/forms.schema

/usr/local/bin/sqlite3 ${MYPATH}/forms.sqlite << EOF
BEGIN TRANSACTION;
INSERT INTO forms ( param,desc,defaults,mandatory,attr ) VALUES ( "fqdn","Real FQDN (eg: ldap.my.domain)",'',1, "maxlen=20" );
INSERT INTO forms ( param,desc,defaults,mandatory,attr ) VALUES ( "ldapcn","Common Name (cn) (eg: Manager)",'Manager',1, "maxlen=20" );
INSERT INTO forms ( param,desc,defaults,mandatory,attr ) VALUES ( "mgmtpassword","Manager password",'',1, "maxlen=30" );
INSERT INTO forms ( param,desc,defaults,mandatory,attr ) VALUES ( "ldapsuffix","LDAP Suffix (eg: dc=example,dc=com)",'dc=example,dc=com',1, "maxlen=30" );
COMMIT;
EOF


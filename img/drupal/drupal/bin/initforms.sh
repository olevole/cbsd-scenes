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
INSERT INTO forms ( param,desc,defaults,mandatory,attr ) VALUES ( "rootpw","Please enter MySQL root password",'',1, "maxlen=20" );
INSERT INTO forms ( param,desc,defaults,mandatory,attr ) VALUES ( "drupalpw","Please enter MySQL Drupal user password",'',1, "maxlen=20" );
INSERT INTO forms ( param,desc,defaults,mandatory,attr ) VALUES ( "fqdn","Please enter vhost FQDN",'',1, "maxlen=30" );
COMMIT;
EOF


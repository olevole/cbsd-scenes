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
INSERT INTO forms ( param,desc,defaults,mandatory,attr ) VALUES ( "mypw","Please enter MySQL root password",'',1, "maxlen=20" );
INSERT INTO forms ( param,desc,defaults,mandatory,attr ) VALUES ( "hosts","Hosts - allowed connection from, IP address or % - any:",'%',1, "maxlen=20" );
INSERT INTO forms ( param,desc,defaults,mandatory,attr ) VALUES ( "network","TCP/IP binding? 0 - unix.socket only, 1 -tcp/ip socket",'0',1, "maxlen=30" );
COMMIT;
EOF

JAIL_ROOT_DIR="${jailsysdir}/${jname}"
SKEL_DIR="${JAIL_ROOT_DIR}/skel"
PRODUCT="redmine"

# keep this settins for imghelper
formfile="${JAIL_ROOT_DIR}/bin/forms.sqlite"

install_img()
{
	chroot ${path} /bin/sh << EOF
/root/skel/rmdb ${rootpw} ${redminepw}
/root/skel/rmprepare ${fqdn} ${redminelang}
rm -rf /root/skel
EOF

	# cleanup
	# remove CBSD pkg repos
	[ -d "${path}/usr/local/etc/pkg" ] && rm -rf "${path}/usr/local/etc/pkg"
}

img_message()
{
	echo
	${ECHO} "${BOLD}=======================================${NORMAL}"
	${ECHO} "${MAGENTA}${PRODUCT} installed. After jail start, default installation${NORMAL}"
	${ECHO} "${MAGENTA}will be available via: ${GREEN}http://${fqdn}${NORMAL}"
	${ECHO} "with default Redmine credential:${NORMAL}"
	${ECHO} "${MAGENTA}Login: ${GREEN}admin${NORMAL}"
	${ECHO} "${MAGENTA}Password: ${GREEN}admin${NORMAL}"
	echo
	${ECHO} "${MAGENTA}Database for ${PRODUCT}: ${GREEN}${PRODUCT}${NORMAL}"
	${ECHO} "${MAGENTA}MySQL password stored in /root/etc/mypw file${NORMAL}"
	echo
}

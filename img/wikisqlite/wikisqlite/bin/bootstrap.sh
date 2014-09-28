JAIL_ROOT_DIR="${jailsysdir}/${jname}"
SKEL_DIR="${JAIL_ROOT_DIR}/skel"
PRODUCT="wordpress"

# keep this settins for imghelper
formfile="${JAIL_ROOT_DIR}/bin/forms.sqlite"

install_img()
{
	[ ! -d "${path}/usr/local/etc/nginx/vhosts" ] && mkdir -p "${path}/usr/local/etc/nginx/vhosts"
	sed s:MY.HOSTNAME:${fqdn}:g ${SKEL_DIR}/etc/vhost.conf > ${path}/usr/local/etc/nginx/vhosts/${PRODUCT}.conf

	chroot ${path} /bin/sh << EOF
/root/skel/prepare
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
	echo
	${ECHO} "${MAGENTA}Current wiki is configured for: ${GREEN}SQLite3 DB${NORMAL}"
	echo
}

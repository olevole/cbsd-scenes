JAIL_ROOT_DIR="${jailsysdir}/${jname}"
SKEL_DIR="${JAIL_ROOT_DIR}/skel"
PRODUCT="owncloud"

# keep this settins for imghelper
formfile="${JAIL_ROOT_DIR}/bin/forms.sqlite"

install_img()
{
	sed s:MY.HOSTNAME:${fqdn}:g ${SKEL_DIR}/etc/vhost.conf > ${path}/usr/local/etc/apache24/Includes/owncloud.conf

	# cleanup
	# remove CBSD pkg repos
	[ -d "${path}/usr/local/etc/pkg" ] && rm -rf "${path}/usr/local/etc/pkg"
}

img_message()
{
	echo
	${ECHO} "${BOLD}=======================================${NORMAL}"
	${ECHO} "${MAGENTA}${PRODUCT} installed. After jail start, default installation${NORMAL}"
	${ECHO} "${MAGENTA}will be available via: ${GREEN}http://${fqdn}/owncloud${NORMAL}"
	echo
	${ECHO} "${MAGENTA}Default login: ${GREEN}admin${NORMAL}"
	${ECHO} "${MAGENTA}Default pass: ${GREEN}admin${NORMAL}"
	echo
}

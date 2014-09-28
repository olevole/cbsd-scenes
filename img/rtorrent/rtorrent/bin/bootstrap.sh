JAIL_ROOT_DIR="${jailsysdir}/${jname}"
SKEL_DIR="${JAIL_ROOT_DIR}/skel"
PRODUCT="rtorrent"

# keep this settins for imghelper
formfile="${JAIL_ROOT_DIR}/bin/forms.sqlite"

install_img()
{
	[ ! -d "${path}/usr/local/etc/nginx/vhosts" ] && mkdir -p "${path}/usr/local/etc/nginx/vhosts"
	sed s:MY.HOSTNAME:${fqdn}:g ${SKEL_DIR}/etc/vhost.conf > ${path}/usr/local/etc/nginx/vhosts/${PRODUCT}.conf
	# set perms for web user (1001 uid)
	[ -d "${path}/usr/home/web" ] && find ${path}/usr/home/web -exec chown 1001:1001 {} \;
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
}

JAIL_ROOT_DIR="${jailsysdir}/${jname}"
SKEL_DIR="${JAIL_ROOT_DIR}/skel"
PRODUCT="drupal"

# keep this settins for imghelper
formfile="${JAIL_ROOT_DIR}/bin/forms.sqlite"

install_img()
{
	sed s:MY.HOSTNAME:${fqdn}:g ${SKEL_DIR}/etc/vhost.conf > ${path}/usr/local/etc/apache24/Includes/drupal.conf
	chroot ${path} /bin/sh << EOF
/root/skel/mysql ${rootpw} ${drupalpw}
/root/skel/prepare ${fqdn}
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
	${ECHO} "${MAGENTA}To compete install follow instruction on ${GREEN}http://${fqdn}/drupal${NORMAL}"
	${ECHO} "${MAGENTA}Database for drupal: ${GREEN}drupal${NORMAL}"
	${ECHO} "${MAGENTA}Database User for drupal database: ${GREEN}drupal${NORMAL}"
	${ECHO} "${MAGENTA}MySQL password stored in /root/etc/mypw file${NORMAL}"
	${ECHO} "${MAGENTA}Known issue: if you got blank screen during \"Set up database\"  in installer, just reload page by pressing F5${NORMAL}"
	echo
}

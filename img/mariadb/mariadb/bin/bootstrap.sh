JAIL_ROOT_DIR="${jailsysdir}/${jname}"
SKEL_DIR="${JAIL_ROOT_DIR}/skel"
PRODUCT="mariadb"

# keep this settins for imghelper
formfile="${JAIL_ROOT_DIR}/bin/forms.sqlite"

install_img()
{
	chroot ${path} /bin/sh << EOF
/root/skel/mysql ${mypw} ${hosts} ${network}
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
	${ECHO} "${MAGENTA}${PRODUCT} installed.${NORMAL}"
	echo
	${ECHO} "${MAGENTA}MySQL password stored in /root/etc/mypw file${NORMAL}"
	echo
}

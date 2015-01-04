JAIL_ROOT_DIR="${jailsysdir}/${jname}"
SKEL_DIR="${JAIL_ROOT_DIR}/skel"
PRODUCT="gitlab"

# keep this settins for imghelper
formfile="${JAIL_ROOT_DIR}/bin/forms.sqlite"

install_img()
{
	chroot ${path} /bin/sh /root/skel/rmdb
	chroot ${path} /root/skel/rmprepare ${fqdn}
	/bin/rm -rf ${path}/root/skel

	# cleanup
	# remove CBSD pkg repos
	[ -d "${path}/usr/local/etc/pkg" ] && rm -rf ${path}/usr/local/etc/pkg
}

img_message()
{
	echo
	${ECHO} "${BOLD}=======================================${NORMAL}"
	${ECHO} "${MAGENTA}${PRODUCT} installed.${NORMAL}"
	echo
	cat <<EOF
	1)
		Use http://fqdn for login to ldapphpadmin. Login DN is:
		"cn=$ldapcn,$ldapsuffix"
		or ldapvi for account management
	2)
		Use
		% ldapadd -Z -D "cn=$ldapcn,$ldapsuffix" -W -f /path/to/ldif
		for create user from LDIF: see
		/root/example_user.ldif as example for testuser1
	3)
		For enable ldap-based auth in the jail from LDAP,
		add follow packages:
		   security/pam_mkhomedir security/pam_ldap net/nss_ldap
		For example from pkg:
		% pkg install pam_mkhomedir pam_ldap nss_ldap
		And use /root/pam.d/ssh (if needed)
		and
		/root/etc/nsswitch.conf
		as sample for your
		/etc/pam.d/sshd and /etc/nsswitch.conf files

EOF
}

# $FreeBSD: releng/9.1/etc/root/dot.cshrc 234978 2012-05-03 19:55:36Z eadler $
#
# .cshrc - csh resource script, read at beginning of execution by each shell
#
# see also csh(1), environ(7).
# more examples available at /usr/share/examples/csh/
#

alias h		history 25
alias j		jobs -l
alias la	ls -aF
alias lf	ls -FA
alias ll	ls -lAF

# A righteous umask
umask 22

set path = (/sbin /bin /usr/sbin /usr/bin /usr/games /usr/local/sbin /usr/local/bin $HOME/bin)

setenv	EDITOR	vi
setenv	PAGER	less
setenv	BLOCKSIZE	K

if ($?prompt) then
	# An interactive shell -- set some stuff up
	if ($uid == 0) then
		set user = root
	endif
	set prompt = "%{^[[40;35;1m%}`/bin/hostname -s`:%{^[[40;31;1m%}%/@%{^[[40;33;1m%}%B[%T]%b # "
	set promptchars = "%#"

	set filec
	set history = 1000
	set savehist = (1000 merge)
	set autolist = ambiguous
	# Use history to aid expansion
	set autoexpand
	set autorehash
	set mail = (/var/mail/$USER)
	if ( $?tcsh ) then
		bindkey "^W" backward-delete-word
		bindkey -k up history-search-backward
		bindkey -k down history-search-forward
	endif

endif

if( `tty` == "/dev/ttyv0" ) then
    [ ! -f /etc/X11/xorg.conf ] && /root/bin/xconfig
    xinit
endif
#!/bin/bash

#super stupid test for new profiles. but it works

# path to profiles directory in repo with my PR checked out
profile_repodir=~/src/gentoo-github/profiles

oldprofiles=(
	default/linux/powerpc/ppc32/17.0
  	default/linux/powerpc/ppc32/17.0/desktop
  	default/linux/powerpc/ppc32/17.0/desktop/gnome
  	default/linux/powerpc/ppc32/17.0/desktop/gnome/systemd
  	default/linux/powerpc/ppc32/17.0/developer
  	default/linux/powerpc/ppc32/17.0/musl
  	default/linux/powerpc/ppc32/17.0/musl/hardened
  	default/linux/powerpc/ppc32/17.0/uclibc
 	default/linux/powerpc/ppc32/17.0/uclibc/hardened
	default/linux/powerpc/ppc64/17.0/64bit-userland
	default/linux/powerpc/ppc64/17.0/64bit-userland/desktop
	default/linux/powerpc/ppc64/17.0/64bit-userland/desktop/gnome
	default/linux/powerpc/ppc64/17.0/64bit-userland/desktop/gnome/systemd
	default/linux/powerpc/ppc64/17.0/64bit-userland/developer
	default/linux/powerpc/ppc64/17.0/64bit-userland/little-endian
	default/linux/powerpc/ppc64/17.0/64bit-userland/little-endian/systemd
)


newprofiles=(
	default/linux/ppc/17.0
	default/linux/ppc/17.0/desktop
	default/linux/ppc/17.0/desktop/gnome
	default/linux/ppc/17.0/desktop/gnome/systemd
	default/linux/ppc/17.0/developer
	default/linux/ppc/17.0/musl
	default/linux/ppc/17.0/musl/hardened
	default/linux/ppc/17.0/uclibc
	default/linux/ppc/17.0/uclibc/hardened
	default/linux/ppc64/17.0
	default/linux/ppc64/17.0/desktop
	default/linux/ppc64/17.0/desktop/gnome
	default/linux/ppc64/17.0/desktop/gnome/systemd
	default/linux/ppc64/17.0/developer
	default/linux/ppc64le/17.0
	default/linux/ppc64le/17.0/systemd
)


for index in ${!oldprofiles[*]}; do
	old="${oldprofiles[$index]}"
	new="${newprofiles[$index]}"
	echo "####################"
	echo "${old} is now ${new}"
	echo
	olddir="${old//\//_}" 
	newdir="${new//\//_}"
	#echo "dumping ${profile_repodir}/${old}"
	./profile-dumper "${profile_repodir}/${old}" "${olddir}" >/dev/null
	./profile-dumper "${profile_repodir}/${new}" "${newdir}" >/dev/null
	#sed -i 's/USE_EXPAND_VALUES_ARCH//g' "${olddir}/make.defaults"
	#sed -i 's/USE_EXPAND_VALUES_ARCH//g' "${newdir}/make.defaults"
	
	
	diff -u "${olddir}" "${newdir}"
	echo "********************"
	echo
	echo
	rm -r "${olddir}" "${newdir}"
done

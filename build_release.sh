#! /bin/bash


usage() {
	echo "$0 <version>"
}


if [ "$1" == "" ]; then
	usage
	exit
fi

version=$1
content=(ctl)
builddir="dns-proxy"

createbuildenv() {
	mkdir ${builddir}
	for p in "${content[@]}"; do
		#echo "$p"
		cp ${p} ${builddir}
	done	
}

zipsrc() {
	zip -r $builddir-${version}.zip ${builddir} 
}


rmbuildenv(){
	rm -rf ${builddir}
}

createbuildenv
zipsrc
rmbuildenv

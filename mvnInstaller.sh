#!/bin/bash
set -x 
###################################################################################################
#   This is reusable function for maven installation.
#   The function expects one parameter - url of maven binary.
#   Example of usage: 
#   installMaven "http://apache.cbox.biz/maven/maven-3/3.3.9/binaries/apache-maven-3.3.9-bin.tar.gz"
###################################################################################################
function installMaven {
	declare -r apacheMavenDownloadUrl=$1
	declare -r directoryName="mvn/"

	if [[ $apacheMavenDownloadUrl =~ ([^/]+)\-([^\-]+)\-bin\.tar\.gz$ ]]
	then
		declare -r resultFileName=$BASH_REMATCH
		declare -r resultDirectoryName="${BASH_REMATCH[1]}-${BASH_REMATCH[2]}"
		declare -r mavenVersion=${BASH_REMATCH[2]}
	else 
		printf "\nIncorrcet format of Apache Maven download url!\n"
		exit 1  
	fi
    
        mkdir -p $directoryName
	cd $directoryName
	wget $apacheMavenDownloadUrl
	tar -zxf $resultFileName
	declare -r workingDir=$(pwd)
	sudo ln -s "$workingDir/$resultDirectoryName/bin/mvn" /usr/local/bin/mvn
	rm -v $resultFileName
	printf "\nMaven $mavenVersion is installed!\n"
}

installMaven "http://apache.cbox.biz/maven/maven-3/3.3.9/binaries/apache-maven-3.3.9-bin.tar.gz"

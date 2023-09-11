#!/bin/bash -e
PKG_DB_DIR=$1; shift
BOOTSTRAP_STAGE=$1; shift
if [[ $BOOTSTRAP_STAGE == *3* ]]; then
#	$PKG_DB_DIR/spkg-tools/locales
	echo " * Installing Temporary tools"
	spkg $@ -e @temptools || exit 1
fi
if [[ $BOOTSTRAP_STAGE == *4* ]]; then
	echo " * Installing the basic system"
	spkg $@ -e @basicsystem || exit 1
fi

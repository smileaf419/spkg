#!/bin/bash -e
PKG_DB_DIR=$1; shift
BOOTSTRAP_STAGES=$1; shift
if [[ $BOOTSTRAP_STAGES == *3* ]]; then
	BOOTSTRAP_STAGE=3
	$PKG_DB_DIR/spkg-tools/locales
	echo " * Installing Temporary tools"
	spkg $@ -e @temptools || exit 1
fi
if [[ $BOOTSTRAP_STAGES == *4* ]]; then
	BOOTSTRAP_STAGE=4
	echo " * Installing the basic system"
	spkg $@ -e @basicsystem || exit 1
fi
rm /tmp/.spkg-bootstrap.lock

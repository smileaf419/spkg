#!/bin/bash
set -e
echo " * Installing locales"
$1/spkg-tools/locales
echo " * Installing Temporary tools"
spkg @temptools
echo " * Installing the basic system"
spkg -e @basicsystem

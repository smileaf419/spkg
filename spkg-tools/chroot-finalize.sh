#!/bin/bash
set -e
$1/spkg-tools/locales
shift
echo " * Installing Temporary tools"
spkg $@ @temptools
echo " * Installing the basic system"
spkg $@ -e @basicsystem

# spkg
Bash based package manager based roughly after Gentoo's Portage.<br/>
This is intended to be a playground for learning about package management and not right now intended as a serious distribution.

# To Use
<code>mkdir -p /var/{lib/spkg,db}
git clone https://github.com/smileaf419/spkg /var/lib/spkg
git clone https://github.com/smileaf419/spkg-repository /var/db/spkg
cp /var/lib/spkg/etc/spkg.conf /etc
</code>

For more information on how to setup and use spkg please check out our [Wiki](https://github.com/smileaf419/spkg/wiki)

# Helper scripts

<b>depcheck</b> : Scans PATH and LD_LIBRARY_PATH for any broken dynamic links

<b>readlatestlog</b> : Utility to read the latest build log file of a package.

<b>etc-update</b> : Near identical to Gentoo's etc-update. Scans /etc for any protected config files and shows the difference in what would be changed. Allows the user to apply the update or delete it.

## Repository Tools

<b>check-update</b> : Uses wget to grab the index of a gentoo mirror and checks the files listed for updates.

<b>clean-db</b> : Cleans the repository keeping only the 3 most recent versions.

<b>clean-archive</b> : Cleans the archives of old versions.

<b>clean-distfiles</b> : Cleans out old downloaded source code files/packages

<b>clean-logs</b> : Cleans out old log files


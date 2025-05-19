# spkg
Bash based package manager based roughly after Gentoo's Portage.
This is intended to be a playground for learning about package management and not right now intended as a serious distribution.

# To Use
<code>
mkdir -p /var/{lib/spkg,db}
git clone https://github.com/smileaf419/spkg /var/lib/spkg/bin
git clone https://github.com/smileaf419/spkg-repository /var/db/spkg
cp /var/lib/spkg/bin/spkg.conf /etc
</code>

For more information on how to setup and use spkg please check out our [Wiki](https://github.com/smileaf419/spkg/wiki)

# Helper scripts
I've shamelessly written a script that scrape data from gentoo's repository

<b>check-update</b> : uses wget to grab the index of a gentoo mirror and checks the files listed for updates.

Repository Tools

<b>clean-db</b> : Cleans the repository keeping only the 3 most recent versions.

<b>clean-archive</b> : Cleans the archives of old versions.

<b>clean-distfiles</b> : Cleans out old downloaded source code files/packages

<b>clean-logs</b> : Cleans out old log files

<b>etc-update</b> : Near identical to Gentoo's etc-update. Scans /etc for any protected config files and shows the difference in what would be changed. Allows the user to apply the update or delete it.

<b>depcheck</b> : scans PATH and LD_LIBRARY_PATH for any broken dynamic links

<b>readlatestlog</b> : Utility to read the latest build log file of a package.

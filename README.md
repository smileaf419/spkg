# spkg
Bash based package manager

A Poorly written package manager roughly based around Gentoo's Portage.
Most packages if they exist within portage are in the same locations to aid in package updates.

This is not intended as more than a playground for learning about package management,
Toying with Cross compilation, etc.

This is not intended to compete with Gentoo's portage or any distribution.
Speed of the package manager is not a priority but rather simplicity in use and development of package files.

# To Use
spkg-tools contains the scripts, I recommend symlinking the spkg script to a dir within your path

<b>INSTALL_PATH</b> must be set within the /etc/spkg.conf to wherever you've placed the scripts.
on first run a default /etc/spkg.conf should be created if ran as root.

<b>BUILD_USER</b> and <b>TEST_USER</b> must be set to actual accounts or you can create a spkg user and use the default.

<b>BUILD_USER</b> & <b>TEST_USER</b> should have read/write access to the <b>WORKDIR_BASE</b> dir.

# /etc/spkg.conf
<b>MAKEOPTS</b>: extra options to pass to make, such as -j<num> or -s to make commands silent.

<b>CFLAGS</b> <b>CXXFLAGS</b>

<b>USE</b> Gentoo like enables and disables certain options within packages.

<b>PAGE</b> Groff option set to either 'letter' (US) or 'A4' (everyone else)

<b>BUILD_PACKAGE</b> (yes|no) If set to 'yes' will create an archive within PKG_ARCHIVE_DIR

<b>PKG_ARCHIVE_DIR</b> path to where archives will be stored. (default: /var/lib/spkg/archive)

<b>ENABLE_TESTS</b> (yes|no) Best to keep to 'no' and use --enable-tests on certain packages.

<b>INSTALL_DOCS</b> (yes|no) set to 'yes' to free up some extra space if you don't actually read or want any extra documentation

<b>LOGDIR</b> path to where logs should be kept (default: /var/log/spkg)

<b>LOGFILE</b> Unimplemented: file name to use for log files.

<b>PKG_DB_DIR</b> path to build files. (default: /var/db/spkg)

<b>PKG_CACHE</b> path to data pkg data files (default: /var/lib/spkg/data)

<b>DISTFILES</b> path to download source and patch files (default: /var/lib/spkg/files)

<b>PKG_WORLD</b> path to the world file, this file stores all explicitly installed packages. (default: /var/lib/spkg/world)

<b>WORKDIR_BASE</b> path to where to build packages (default: /var/tmp/spkg)

<b>ROOT</b> DANGEROUS: this sets what root directory to install all files to. (default: /)

# Helper scripts
I've shamelessly written scripts that scrape data from gentoo's repository or a portage dir

<b>check-update</b> : uses wget to grab the index of a gentoo mirror and checks the files listed for updates.

<b>check-portage</b> : checks ebuilds against build files for version upgrades.

Both scripts need to be replaced with a more respectable way.

Repository Tools

<b>clean-db</b> : Cleans the repository keeping only the 3 most recent versions.

<b>clean-archive</b> : Cleans the archives of old versions.

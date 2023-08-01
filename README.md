# spkg
Bash based package manager based roughly after Gentoo's Portage.
This is intended to be a playground for learning about package management and not right now intended as a serious distribution.

Join me at: https://discord.gg/DQR42sWk

# To Use
spkg-tools contains the scripts, I recommend symlinking the spkg script to a dir within your path

<b>INSTALL_PATH</b> must be set within the /etc/spkg.conf to wherever you've placed the scripts.
on first run a default /etc/spkg.conf should be created if ran as root.

<b>BUILD_USER</b> must be set to actual accounts or you can create a spkg user and use the default.

<b>BUILD_USER</b> should have read/write access to the <b>WORKDIR_BASE</b> dir.

# /etc/spkg.conf
<b>MAKEOPTS</b>: extra options to pass to make, such as -j<num> or -s to make commands silent.

<b>CFLAGS</b> <b>CXXFLAGS</b>: Compile time optimizations

<b>USE</b> Gentoo like enables and disables certain options within packages.

<b>PAGE</b> Groff option set to either 'letter' (US) or 'A4' (everyone else)

<b>BUILD_PACKAGE</b> (yes|no) If set to 'yes' will create an archive within PKG_ARCHIVE_DIR

<b>PKG_ARCHIVE_DIR</b> path to where archives will be stored. (default: /var/lib/spkg/archive)

<b>ENABLE_TESTS</b> (yes|no) Best to keep to 'no' and use --enable-tests on certain packages.

<b>INSTALL_DOCS</b> (yes|no) set to 'yes' to free up some extra space if you don't actually read/want any documentation

<b>LOGDIR</b> path to where logs should be kept (default: /var/log/spkg)

<b>LOGFILE</b> File name to use for log files.

<b>PKG_DB_DIR</b> path to build files. (default: /var/db/spkg)

<b>PKG_CACHE</b> path to data pkg data files (default: /var/lib/spkg/data)

<b>DISTFILES</b> path to download source and patch files (default: /var/lib/spkg/files)

<b>PKG_WORLD</b> path to the world file, this file stores all explicitly installed packages. (default: /var/lib/spkg/world)

<b>WORKDIR_BASE</b> path to where to build packages (default: /var/tmp/spkg)

# Helper scripts
I've shamelessly written a script that scrape data from gentoo's repository

<b>check-update</b> : uses wget to grab the index of a gentoo mirror and checks the files listed for updates.

Repository Tools

<b>clean-db</b> : Cleans the repository keeping only the 3 most recent versions.

<b>clean-archive</b> : Cleans the archives of old versions.

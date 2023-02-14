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
INSTALL_PATH must be set within the /etc/spkg.conf to wherever you've placed the scripts.
on first run a default /etc/spkg.conf should be created if ran as root.

BUILD_USER and TEST_USER must be set to actual accounts or you can create a spkg user and use the default.

BUILD_USER & TEST_USER should have read/write access to the PYTHON_VM dir.

# Helper scripts
I've shamelessly written scripts that scrape data from gentoo's repository or a portage dir

<b>check-update</b> : uses wget to grab the index of a gentoo mirror and checks the files listed for updates.

<b>check-portage</b> : checks ebuilds against build files for version upgrades.

Both scripts need to be replaced with a more respectable way.

Repository Tools

<b>clean-db</b> : Cleans the repository keeping only the 3 most recent versions.

<b>clean-archive</b> : Cleans the archives of old versions.

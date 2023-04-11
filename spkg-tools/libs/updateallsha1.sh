#!/bin/bash
####
## Finds and updates sha1sum for all files.
## Author: Stephen Leaf <smileaf@me.com>
## Date: 2022-07-24 (Last Updated: 2023-04-09)

# Set a few flags to ensure everything gets fetched and hashed.
VERIFY_SIG=0
ENABLE_TESTS=1
IGNORE_SHA=1

hash_file() {
	PKG_BLD=$1
	PKG_DIR=${1%/*}
	PKG=$(DB-getPkg ${PKG_BLD##*/}|sed 's,.build$,,')
	PKG_VER=$(getVersion $PKG)
	PKG_NAME=$(getName $PKG)
	if [[ $VERBOSE -ge 2 ]]; then
		echo PKG_BLD : $PKG_BLD
		echo PKG_DIR : $PKG_DIR
		echo PKG_VER : $PKG_VER
		echo PKG_NAME: $PKG_NAME
	fi

	sha1sum $PKG_BLD | sed 's,  .*/,  ,'>> $DIR/sha1
	
	# FIXME: We might need to 'import' IUSE and temp set it as our
	# USE if we decide to use this to include other files/patches.
	(
		b=$(ls -1 $PKG_DIR/*.build|sort -d)
		source $PKG_BLD
		fetch_list "" SRC_URI 'src'
		fetch_list "" PATCHES 'patch'
	)
}

hash_dir() {
	echo -n "Updating: ${1##*/}"
	[[ -e $1/sha1 ]] && rm $1/sha1 #> /dev/null 2>&1
	for f in $(find $1 -type f -name *.build); do
		sha1sum "$f" | sed 's,  .*/,  ,' >> $1/sha1
		echo -n " [$(echo $f|sed -e 's,.build$,,' -e "s,$PKG_DB_DIR/,,"):"
		(
			PKG=$(DB-getPkg $(echo $f|sed -e 's,.build$,,' -e "s,$PKG_DB_DIR/,,"))
			PKG_VER=$(getVersion $PKG)
			PKG_NAME=$(getName $PKG)
			source $f
			fetch_list "" SRC_URI 'src'
			fetch_list "" PATCHES 'patch'
		)
		echo -n "]"
	done
	echo " .. done"
}

# 1: File to verify
# 2: Path
verifySha1() {
	h=$(sha1sum $1 | sed 's,  .*/,  ,' 2> /dev/null)
	grep "$h" $2/sha1 > /dev/null 2>&1
}

updatesha1() {
	cd $PKG_DB_DIR
	if [[ $1 == "all" ]]; then
		L=$(find $PKG_DB_DIR -mindepth 2 -type d | sed "s,$PKG_DB_DIR/,,")
	else
		L=$(find $PKG_DB_DIR/$1 -type d | sed "s,$PKG_DB_DIR/,,")
	fi
	for d in $L; do
		[[ $d == "spkg-sets" || $d == "spkg-tools/libs" || $d == *.git/* ]] && continue
		echo -n $d
		DIR=$PKG_DB_DIR/$d
		# If it exists, grab a list of build files,
		#	gather a list of files within each
		#   and verify them all via the sha1 file
		if [ -e $DIR/sha1 ]; then
			echo -n "["
			for f in $(find $DIR -type f -name *.build); do
				echo -n " "$(sed -E -e 's,^.*/,,' -e 's,.build$,,'  <<< $f)
				verifySha1 $f $DIR
				# if any fail, rehash the entire directory.
				if [[ $? != 0 ]]; then
					hash_dir $DIR
					break
				# If all is Ok source it and verify the SRC_URI and PATCHES.
				else
					(
						PKG=$(DB-getPkg $(echo $f|sed -e 's,.build$,,' -e "s,$PKG_DB_DIR/,,"))
						PKG_VER=$(getVersion $PKG)
						PKG_NAME=$(getName $PKG)
						source $f

						length=${#SRC_URI[@]}
						for (( l=0; l<${length}; l++ )); do
							file=${SRC_URI[$l]}
							[[ $file == "" ]] && continue
							if [[ $file =~ (^|[[:space:]])"=>"($|[[:space:]]) ]]; then
								export SRC_OUTFILE=${file/*=> /}
					            export SRC_FILE=${file/ =>*/}
						    else
								export SRC_FILE=$file
								export SRC_OUTFILE=${SRC_FILE##*/}
							fi
						    if [ ! -f "${DISTFILES}/${SRC_OUTFILE}" ]; then
								fetch_file "$SRC_FILE" "$SRC_OUTFILE"
						    fi
						    [[ $SRC_OUTFILE == "" ]] && continue
							verifySha1 "${DISTFILES}/${SRC_OUTFILE}" $DIR
							# If any files fail, rehash the entire directory.
							if [[ $? != 0 ]]; then
								hash_dir $DIR
								BREAK_PARENT=1
								break
							fi
						done
						[[ $BREAK_PARENT == 1 ]] && BREAK_PARENT=0 && exit 1
						length=${#PATCHES[@]}
						for (( l=0; l<${length}; l++ )); do
							file=${PATCHES[$l]}
							[[ $file == "" ]] && continue
							if [[ $file =~ (^|[[:space:]])"=>"($|[[:space:]]) ]]; then
								export SRC_FILE=${file/ =>*/}
								export SRC_OUTFILE=${file/*=> /}
							else
								export SRC_FILE=$file
								export SRC_OUTFILE=${SRC_FILE##*/}
							fi
							if [ ! -f "${DISTFILES}/${SRC_OUTFILE}" ]; then
								fetch_file "$SRC_FILE" "$SRC_OUTFILE"
							fi
						    [[ $SRC_OUTFILE == "" ]] && continue
							verifySha1 "${DISTFILES}/${SRC_OUTFILE}" $DIR
							# If any files fail, rehash the entire directory.
							if [[ $? != 0 ]]; then
								hash_dir $DIR
								BREAK_PARENT=1
								break
							fi
							echo -n .
						done
						[[ $BREAK_PARENT == 1 ]] && BREAK_PARENT=0 && exit 1
					)
				fi
			done
			echo " ]"
			# If it does not exists, we need to grab a list of build files
			#	generate a list of files and create our sha1 file.
		else
			hash_dir $DIR
		fi
	done
}

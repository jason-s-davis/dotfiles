alias reload!='. ~/.zshrc'

# The all important nyan command
if [[ -x `which nc` ]]; then
	alias nyan='nc -v nyancat.dakko.us 23' # nyan cat
fi


# Improved whois
# a more accurate and up to date list of whois
# # servers using CNAMES via whois.geek.nz

function iwhois() {
	resolver="whois.geek.nz"
	tld=`echo ${@: -1} | awk -F "." '{print $NF}'`
	whois -h ${tld}.${resolver} "$@" ;
}

# Jenkins Build

function jbuild() {
	# This script will generate and submit build parameters
	# as a POST request to Jenkins at the url below.
	# The build parameters will be generated as follows:
	# GIT_REPO    the repo you are currently in
	# GIT_BRANCH  the git branch you are currently in
	# COPY_SRC    your current (calling) directory (below the git root)
	# COPY_DEST   the contents of COPY_SRC above with current directory removed

	JENKINS="192.168.175.209"
	URL="http://$JENKINS:8080/job/SCBZ_PROTOTYPE/buildWithParameters"

	# verify connection to Jenkins server before continuing
	connectiontest="true"
	ping -q -W 1 -c 1 $JENKINS &> /dev/null || connectiontest="false"

	if [[ "$connectiontest" == 'false' ]]; then
		echo " "
		echo "****** WARNING ******"
		echo "Could not establish connection to JENKINS @ $JENKINS"
		echo "Are you connected to the VPN?"
		echo " "
		exit;
	fi

	GIT_REPO=$(basename "$(git rev-parse --show-toplevel)")
	GIT_BRANCH=$(git rev-parse --abbrev-ref HEAD)

	## get path information
	path=$(pwd)
	# split path by git repo name
	splitpath=(${path//$GIT_REPO/ })
	# get the directory we are in
	currentdir=${PWD##*/}

	# get the path to working dir after the repo name
	# and remove the leading slash from directory
	COPY_SRC="${splitpath[1]:1}"

	# remove the current directory from our copy path
	COPY_DEST=${COPY_SRC//\/$currentdir/ }

	DELETE_FLAG='FALSE'

	# warn user if the current directory is htdocs or live (good call Lami)
	# which means overwriting all of htdocs / live on UAT
	if [[ "$currentdir" == 'htdocs' || "$currentdir" == 'live' ]]; then
		echo " "
		echo "****** WARNING ******"
		echo "You are attempting to overwrite all subdirectires of $currentdir on $GIT_REPO!"
		echo "This might affect other people's work."
		echo "Do you want to continue? (1 | 2)"
		select yn in "Yes" "No"; do
			case $yn in
				Yes ) break;;
				No ) exit;;
			esac
		done
	fi

	# test for single file update and only post that file
	# instead of the whole directory
	filecount=$(git diff HEAD~1 --name-only | wc -l)
	if [ "$filecount" -lt "2" ] && [ "$filecount" -gt "0" ]; then
		diff_file=$(git diff HEAD~1 --name-only)
		# if [ "$currentdir" == "$(echo "$diff_file" | rev | cut -d/ -f2 | rev)" ]; then
		COPY_SRC=$diff_file
		filename=$(echo "$COPY_SRC" | rev | cut -d/ -f1 | rev)
		COPY_DEST=${COPY_SRC%$filename}
		# fi
	fi

	# gather params
	CURLDATA="GIT_REPO=$GIT_REPO&GIT_BRANCH=$GIT_BRANCH&COPY_SRC=$COPY_SRC&COPY_DEST=$COPY_DEST&DELETE_FLAG=$DELETE_FLAG"

	# uncomment this for debugging
	# status=$(curl --data "$CURLDATA" $URL);
	# echo $status;

	# send the data to jenkins as a POST request
	# *NOTE* this step will need modification if Jenkins has auth added
	curl --data "$CURLDATA" $URL

	# Log our request params
	echo "Build parameters sent to JENKINS";
	echo "@ $URL";

	# uncomment these to see the params being sent
	echo "$GIT_REPO"
	echo "$GIT_BRANCH"
	echo "$COPY_SRC"
	echo "$COPY_DEST"
}

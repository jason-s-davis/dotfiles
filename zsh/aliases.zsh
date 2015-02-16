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

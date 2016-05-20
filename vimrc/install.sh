# vim
apt-get uninstall -y vim
apt-get update
apt-get install -y vim

# neo vim

## stuff for python modules
apt-get install -y  python-dev python-pip python3-dev python3-pip

## for add-apt-repository binary
## possibly install python-software-properties on older linux
apt-get install -y software-properties-common add-apt-repository ppa:neovim-ppa/unstable
apt-get update
apt-get install -y neovim

# vundle
## vundle needs git and curl to work
apt-get install -y git curl

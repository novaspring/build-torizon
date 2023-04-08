#!/bin/sh

VERSION=kirkstone-6.x.y
VARIANT=torizoncore/default.xml

mkdir -p ~/bin
PATH=~/bin:$PATH

curl http://commondatastorage.googleapis.com/git-repo-downloads/repo > ~/bin/repo
chmod a+x ~/bin/repo
repo init -u git://git.toradex.com/toradex-manifest.git -b $VERSION -m $VARIANT
repo sync --no-clone-bundle

export MACHINE=verdin-imx8mp 
export DISTRO=torizon 
mkdir -p build/conf
echo 'ACCEPT_FSL_EULA="1"' >build/conf/local.conf
source layers/meta-toradex-torizon/scripts/setup-environment-internal build
echo '+ bitbake torizon-core-docker'
bitbake torizon-core-docker


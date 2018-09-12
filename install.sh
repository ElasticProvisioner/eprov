#!/bin/bash --posix
# https://api.elasticprovisioner.com/install-elastic-provisioner-2018071603
# Author: Asher Bond
# (C) Elastic Provisioner 2011-2018
# Elastic Provisioner is a runtime bootstrapping utility for automated deployment of software application
# code atop a virtual or paravirtual machine or even a physical machine.. if that's what you're into.
# 
# eprov also serves as the client of a Test-Driven-DevOps PaaS framework for distributed systems developers.
#
# Please read the License (AGPL v3)
# https://api.elasticprovisioner.com/LICENSE-AGPLv3.txt
# or
# https://www.gnu.org/licenses/agpl-3.0.de.html
# 
# To install Elastic Provisioner:
# curl https://api.elasticprovisioner.com/install-elastic-provisioner | bash
#
# A STRAP is a Service Template Running A Process
# A STRAP may be licensed to you under similar or different terms.
# A STRAP may be licensed to the public under AGPLv3 or a more permissive license such as LGPL or BSD or GNU or Apache License.
# A user may invoke the STRAP at his or her own risk via eprov <strap> or gitstrapped <strap>
# To install gitstrapped:
# curl https://api.gitstrapped.com/install-gitstrapped | bash
# This software is provided without Warranty.
#
# Please also support the Electronic Frontier Foundation (Defending Your Rights In The Digital World)
# https://www.eff.org/

# defaults
namespace='eprov'
export namespace
export STRAP_PATH='/var/cache'
export STRAP_CACHE="${STRAP_PATH}/elastic-provisioner"
export STRAP_DIR_PERMS=750
export STRAP_PERMS=750

eprov_path='api.elasticprovisioner.com/eprov'
bin_path='/usr/local/bin'
local_path="${bin_path}/${namespace}"

if [ ! "$USER" == 'root' ] && [ -e /etc/sudoers ]; then
	sudo='sudo'
else	sudo=''
fi

if uname | grep -q "BSD" ; then
	ASSUME_ALWAYS_YES=1
	[ ! -e /bin/bash ] && pkg install bash
	[ ! -e /usr/bin/curl ] && [ ! -e /usr/bin/curl ] && [ ! -e /bin/curl ] && pkg install curl
	ln -s /usr/local/bin/bash /bin/bash
fi

$sudo mkdir -p $STRAP_CACHE
$sudo chmod $STRAP_DIR_PERMS $STRAP_CACHE
$sudo chown $USER $STRAP_CACHE
cd $STRAP_CACHE || exit 1

tmpdir=`mktemp -d` 2>/dev/null || tmpdir=`mktemp -d -t elastic-provisioner` 2>/dev/null

if which curl | grep -q curl ; then
	local_dir=`dirname $local_path`
	$sudo mkdir -p $local_dir
	curl -s -1 https://${eprov_path} > ${tmpdir}/${namespace}
elif which wget | grep -q wget ; then
	wget https://$eprov_path --output-document=${tmpdir}/${namespace}
fi

$sudo mv ${tmpdir}/${namespace} $local_path
rm -rf $tmpdir
echo "${namespace} installed."

$sudo chmod 755 $local_path || ( echo "[FATAL]: Couldn't download ${namespace}. Please download https://${eprov_path} to ${local_path}" && exit 73 )

if [ "$1" == 'as' ]; then
	shift
	while [ ! -z "$1" ]; do
		$sudo cp $local_path ${bin_path}/$1
		$sudo mkdir -p /var/cache/$1
		$sudo chown $USER /var/cache/$1
		$sudo chmod $STRAP_DIR_PERMS /var/cache/$1
		echo "$1 installed."
		shift
	done
fi



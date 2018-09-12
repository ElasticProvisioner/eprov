# https://api.eprov.io/eprov.py
# Author: Asher Bond
# (C) Elastic Provisioner 2018
# Elastic Provisioner is a runtime bootstrapping utility for automated deployment of software application
# code atop a virtual or paravirtual machine or even a physical machine.. if that's what you're into.
#
# eprov is the client in a Test-Driven-DevOps PaaS framework for distributed systems developers.
#
# Please read the License (This STRAP and eprov are licensed under AGPL v3)
# https://api.elasticprovisioner.com/LICENSE-AGPLv3.txt
# or
# https://www.gnu.org/licenses/agpl-3.0.de.html
#
# To install eprov:
# curl https://api.elasticprovisioner.com/install-eprov | bash
#
# A STRAP is a Service Template Running A Process
# A STRAP may be licensed to the public under AGPLv3 or a more permissive license such as LGPL or BSD or GNU or Apache License.
# A STRAP may be invoked at your own risk via eprov <strap>
#
# Please support the Electronic Frontier Foundation (Defending Your Rights In The Digital World)
# https://www.eff.org/
#
# system requirements:
# - Python2 or Python3;  Works the same with either version of python!
# - a fully functional shell with posix capabilities. bash is default.
#
# usage:
# >>> from eprov import Eprov
# >>> eprov = Eprov()
# >>> eprov.<strap_using_underscores_instead_of_dashes>('arg', 'arg', 'etc')
#
# usage examples:
# >>> from eprov import Eprov
# >>> eprov = Eprov()
# >>> eprov.aws('ec2','help')
# ...
# NAME
#       ec2 -
#
# DESCRIPTION
#       Amazon  Elastic Compute Cloud (Amazon EC2) provides resizable computing
#        capacity in the Amazon Web Services (AWS) cloud. Using Amazon EC2 elim-
#       inates your need to invest in hardware up front, so you can develop and
#       deploy applications faster.
# ...
# >>> eprov.sum()
# 1 1 1 1 4
# 8
#
# >>> eprov.round('12.5499')
# 13

# non-zero exit codes will raise an exception with the non-zero exit status preserved as part of the output
# >>> eprov.round()
# [SCALE=0|<decimal-precison-n>] eprov round [(--scale|-s) <decimal-precision-n>] <decimal that you want made into a whole number>
# ...
#    raise CalledProcessError(retcode, cmd)
# subprocess.CalledProcessError: Command '['eprov', 'round']' returned non-zero exit status 64

# notice exit status 64

# get a list of exit statuses with eprov.show_exits()

from subprocess import check_call # useful for raising exceptions when exit statuses are nonzero
from shlex import split # useful for handling space separated arguments

class Eprov(object):
    # eprov is the default namespace, but you can define your own namespaces as needed.
    # contact asher.bond@elasticprovisioner.com for information on how Elastic Provisioner delivers 
    # custom APIs for your organization on premise (in your own datacenters) or as a very highly available hosted service.
    def __init__(self, namespace=None):
        if namespace is None:
            namespace = 'eprov'
        self.namespace = namespace

    # strap invocation method here takes full advantage of python introspection.
    def __getattr__(self, name):
        def _strap(*args, **kwargs):
            # strap invocations were modified a bit for the sake of pythonic object-orientation
            # specifically, the strap name may contain a -, but for the sake of methods, we're using _ instead of -.
            gs_invocation = self.namespace + ' ' + name.replace('_', '-') + ' ' + ' '.join(args) + ' '.join(kwargs)
            check_call(split(gs_invocation), shell=False)
        return _strap


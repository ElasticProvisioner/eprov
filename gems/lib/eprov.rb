#!/path/to/ruby
# Author: Asher Bond
# (C) Elastic Provisioner 2013-2018
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
#Module Eprov
  class Eprov 
    attr_reader :client
    def initialize(client='eprov')
      @client = client
      def method_missing(method, *arg)
        @strap = method.to_s.gsub('_','-')
        system(@client.to_s, @strap, *arg)
      end
    end
  end
# (after gem install </path/to/>eprov.gem):
# irb(main):006:0> require 'eprov'
# => true
# irb(main):008:0> eprov = Eprov.new
# => #<Eprov:0x00007fdfaf9be998 @client="eprov">
# (try some of the following)
# eprov.pipe_args('1 1 :: sum')
# 2
# => true
# irb(main):012:0> eprov.pipe_args('1 1 1 1 4 :: sum')
# 8
# => true

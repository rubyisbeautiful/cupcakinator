require 'cupcakinator/version'
require 'cupcakinator/base'
require 'cupcakinator/config'
require 'cupcakinator/options'
require 'cupcakinator/errors'

# the purpose of cupcakinator is to provide an simple, flexible dynamic method to retrrieve configuration
# data for a class
# it provides this dynamic method as 'config' by default for both the class and any instances
# @example class Foo uses cupcakinator, see Cupcakinator::Base::cupcakinate
#   given config.yml:
#   bacon:
#     flavor: pork
#   meatball:
#     flavor:
#       - pork
#       - chicken
#   >> Foo.config
#   {"meatball"=>{"flavor"=>["chicken", "pork"]}}
#   >> Foo.config.meatball
#   {"flavor"=>["chicken", "pork"]}
module Cupcakinator

  def self.included(other)
    other.extend Cupcakinator::Base
  end


end

require "cupcakinator/version"
require 'cupcakinator/base'
require 'cupcakinator/config'
require 'cupcakinator/options'

module Cupcakinator

  def self.included(other)
    other.extend Cupcakinator::Base
  end


end

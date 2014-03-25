require 'hashie/extensions/method_access'
require 'hashie/extensions/coercion'

module Cupcakinator

  # known configuration variables
  # method
  # dir
  # file
  # root_key
  # allow_missing
  class Config < Hash
    include Hashie::Extensions::MethodAccess
    include Hashie::Extensions::Coercion

    coerce_value Hash, Config

    def initialize(h={})
      super
      h.each_pair do |k,v|
        self[k] = v
      end
    end


    # TODO: to_h that returns uncoerced hash

  end

end
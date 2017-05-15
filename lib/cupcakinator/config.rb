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

    # @param [Hash] h
    # @return Cupcakinator::Config
    def initialize(h={})
      super
      h.each_pair do |k,v|
        self[k] = v
      end
    end


    # @return [Hash] returns uncoerced Hash
    def to_h
      convert_config_to_hash(self.dup)
    end


    private


    def convert_config_to_hash(c)
      h = Hash.new
      c.each_pair{ |key, value| Config === value ? h[key] = convert_config_to_hash(value) : h[key] = value }
      h
    end

  end

end
require 'yaml'

module Cupcakinator

  module Base


    def self.included(other)
      other.extend ClassMethods
    end


    def self.extend_object(other)
      other.class_variable_set '@@cupcakinator_options', nil
      other.class_variable_set '@@cupcakinator_config', nil
      super
    end


    def cupcakinate(*options)
      if !options.empty?
        default_options = _cupcakinator_options
        class_variable_set('@@cupcakinator_options', default_options.merge(options.last))
      end
    end


    def _cupcakinator_options
      if class_variable_get('@@cupcakinator_options').nil?
        class_variable_set '@@cupcakinator_options', Cupcakinator::Options.new
      end
      class_variable_get('@@cupcakinator_options')
    end


    def _cupcakinator_config
      if class_variable_get('@@cupcakinator_config').nil?
        yaml_config = YAML.load_file(File.join(_cupcakinator_options[:dir], _cupcakinator_options[:file]))
        class_variable_set('@@cupcakinator_config', Cupcakinator::Config.new(yaml_config))
      end
      class_variable_get('@@cupcakinator_config')
    end


    def method_missing(original_method, *args)
      if original_method.to_s == _cupcakinator_options[:method].to_s
         _cupcakinator_config(*args)
      else
        super
      end
    end


  end


  def method_missing(original_method, *args)
    if original_method.to_s == self.class._cupcakinator_options[:method].to_s
       self.class._cupcakinator_config(*args)
    else
      super
    end
  end

end
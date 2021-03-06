require 'yaml'

module Cupcakinator

  module Base


    def self.included(other)
      raise I18n.t('cupcakinator.error.deprecation.include_base')
    end


    def self.extend_object(other)
      class_eval <<-ENDOFCLASSDEF
        class << self
          @cupcakinator_options = nil;
          @cupcakinator_config = nil;
        end
      ENDOFCLASSDEF
      super
    end


    # this is the main access point to using and setting up cupcakinator
    # it accepts any arguments, the following are currently recognized:
    # @param [Array<Hash>] options
    # @option options.last [Hash] :dir The directory where the file can be found
    # @option options.last [Hash] :file The configuration filename
    # @option options.last [Hash] :method The method used to access the configuration options
    # @option options.last [Hash] :root_key A key in the top level of the config file that will become the base
    # @option options.last [Hash] :allow_missing Allows the config file to be missing, config will return empty Hash
    # @example  Default usage - Foo will load ./config/config.yml into a method named 'config' and raise on missing
    #   class Foo
    #     include cupcakinator
    #     cupcakinate
    #   end
    #   >> puts Foo.config
    #   { :foo => 'bar' }
    #
    # @example  method name change - Foo will load ./config/config.yml into a method named 'le_config'
    #   class Foo
    #     include cupcakinator
    #     cupcakinate method: 'le_config'
    #   end
    #   >> puts Foo.le_config
    #   { :foo => 'bar' }
    #   >> puts Foo.new.le_config
    #   { :foo => 'bar' }
    #
    # @example  with Rails - Foo will load config/foo_config.yml relative to Rails root into a method named 'config'
    #   class Foo
    #     include cupcakinator
    #     cupcakinate dir: Rails.root.join('config'), file: 'foo_config.yml'
    #   end
    #   >> puts Foo.config
    #   { :foo => 'bar' }
    #   >> puts Foo.new.config
    #   { :foo => 'bar' }
    #
    # @example  with Rails - Foo will load config/foo_config.yml relative to Rails root into a method named 'config'
    #           beginning at the root_key based on the Rails.env
    #   class Foo
    #     include cupcakinator
    #     cupcakinate dir: Rails.root.join('config'), file: 'foo_config.yml', root_key: Rails.env
    #   end
    #   >> puts Foo.config
    #   { :foo => 'bar' }
    #   >> puts Foo.new.config
    #   { :foo => 'bar' }
    #
    # @example with no config file
    #
    #   class Foo
    #     include cupcakinator
    #     cupcakinate dir: Rails.root.join('config'), file: 'foo_config.yml', allow_missing: true
    #   end
    #   >> puts Foo.config
    #   {}
    #
    def cupcakinate(*options)
      if !options.empty?
        default_options = _cupcakinator_options
        @cupcakinator_options = default_options.merge(options.last)
      end
    end


    def _cupcakinator_options
      if @cupcakinator_options.nil?
        @cupcakinator_options = Cupcakinator::Options.new
      end
      @cupcakinator_options
    end


    def _cupcakinator_config
      if @cupcakinator_config.nil?
        load_cupcakinator_config
      end
      @cupcakinator_config
    end


    def load_cupcakinator_config
      filename = File.join(_cupcakinator_options[:dir], _cupcakinator_options[:file])
      yaml_config = YAML.load_file(filename)
      if _cupcakinator_options.has_key?(:root_key)
        rk = _cupcakinator_options[:root_key]
        @cupcakinator_config = Cupcakinator::Config.new(yaml_config[rk])
      else
        @cupcakinator_config = Cupcakinator::Config.new(yaml_config)
      end
    rescue Errno::ENOENT
      if (_cupcakinator_options.allow_missing rescue false)
        @cupcakinator_config = Cupcakinator::Config.new({})
      else
        raise Cupcakinator::ConfigFileNotFoundError.new(filename, _cupcakinator_options)
      end
    rescue Psych::SyntaxError => e
      raise Cupcakinator::ConfigFileInvalidError.new(filename, e.message)
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
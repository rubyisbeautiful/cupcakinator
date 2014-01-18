require 'yaml'

module Cupcakinator

  module Base


    def self.included(other)
      raise I18n.t('error.deprecation.include_base')
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
    # @example  Default usage - Foo will load ./config/config.yml into a method named 'config'
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
      @cupcakinator_config = Cupcakinator::Config.new(yaml_config)
    rescue Errno::ENOENT
      raise Cupcakinator::ConfigFileNotFoundError.new(filename, _cupcakinator_options)
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
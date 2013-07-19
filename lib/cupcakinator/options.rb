module Cupcakinator

  # known configuration variables
  # method
  # dir
  # file
  class Options < Cupcakinator::Config

    DEFAULT_OPTIONS = Cupcakinator::Config.new(method: :config, dir: '.', file: 'config.yml')

    def initialize(opts=DEFAULT_OPTIONS)
      super
    end

  end

end

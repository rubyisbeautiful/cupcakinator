module Cupcakinator

  class ConfigFileNotFoundError < StandardError

    def initialize(filename, options)
      super I18n.t('cupcakinator.error.config_not_found', filename: filename, options: options)
    end

  end


  class ConfigFileInvalidError < StandardError

    def initialize(filename, message)
      super I18n.t('cupcakinator.error.config_invalid', filename: filename, message: message)
    end

  end

end
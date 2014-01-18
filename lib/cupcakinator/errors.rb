module Cupcakinator

  class ConfigFileNotFoundError < StandardError

    def initialize(filename, options)
      I18n.t('error.config_not_found', filename: filename, options: options)
    end

  end


  class ConfigFileInvalidError < StandardError

    def initialize(filename, message)
      I18n.t('error.config_invalid', filename: filename, message: message)
    end

  end

end
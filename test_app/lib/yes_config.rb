class YesConfig
  include Cupcakinator

  cupcakinate dir: 'config'

  def foo
    config.foo
  end

end
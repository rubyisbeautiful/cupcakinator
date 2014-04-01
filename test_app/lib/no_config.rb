class NoConfig
  include Cupcakinator

  cupcakinate dir: 'config', file: 'noconfigexists.yml'

  def foo
    config.foo
  end

end
require 'spec_helper'

class Foo
  include Cupcakinator

  cupcakinate method: 'config', file: 'config.yml'
end


describe Cupcakinator do

  context 'inclusion' do

    it "should have the @@cupcakinator_config class variable set" do
       Foo.class_variable_defined?('@@cupcakinator_config').should be_true
     end

  end

end

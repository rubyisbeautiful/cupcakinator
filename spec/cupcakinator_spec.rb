require 'spec_helper'

class CupcakinatorSpecFoo
  include Cupcakinator

  cupcakinate method: 'config', file: 'config.yml'
end

class CupcakinatorSpecBar < CupcakinatorSpecFoo
  cupcakinate method: 'bar_config'
end

class CupcakinatorSpecBaz
  include Cupcakinator

  cupcakinate method: 'baz_config'
end


describe Cupcakinator do

  context 'inheritence' do

    it "parent should not have child's options" do
      CupcakinatorSpecFoo._cupcakinator_options[:method].should == 'config'
    end

    it "child should not have parent's options" do
      CupcakinatorSpecBar._cupcakinator_options[:method].should == 'bar_config'
    end

  end


  context 'multiple uses' do

    it "should exist separately per invocation" do
      CupcakinatorSpecBaz._cupcakinator_options[:method].should_not eq CupcakinatorSpecFoo._cupcakinator_options[:method]
    end

  end

end

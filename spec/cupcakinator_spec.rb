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
      expect(CupcakinatorSpecFoo._cupcakinator_options[:method]).to eq 'config'
    end

    it "child should not have parent's options" do
      expect(CupcakinatorSpecBar._cupcakinator_options[:method]).to eq 'bar_config'
    end

  end


  context 'multiple uses' do

    it "should exist separately per invocation" do
      expect(CupcakinatorSpecBaz._cupcakinator_options[:method]).not_to eq CupcakinatorSpecFoo._cupcakinator_options[:method]
    end

  end


  context 'localization' do

    it 'should have loaded the locales file' do
      expect(I18n.t('cupcakinator.error.deprecation.include_base')).to match /don't include Cupcakinator::Base directly/
    end
  end

end

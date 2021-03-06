require 'spec_helper'

describe Cupcakinator::ConfigFileNotFoundError do

  it 'should call I18n with args filename and options' do
    expect(I18n).to receive(:t).with(an_instance_of(String), hash_including(:filename, :options))
    Cupcakinator::ConfigFileNotFoundError.new('foo', 'bar')
  end

end


describe Cupcakinator::ConfigFileInvalidError do

  it 'should call I18n with args filename and message' do
    expect(I18n).to receive(:t).with(an_instance_of(String), hash_including(:filename, :message))
    Cupcakinator::ConfigFileInvalidError.new('foo', 'bar')
  end

end

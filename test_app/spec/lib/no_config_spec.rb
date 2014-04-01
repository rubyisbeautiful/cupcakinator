require 'spec_helper'

describe NoConfig do


  describe 'foo' do

    it 'should be bar' do
      expect(subject.foo).to eq("bar")
    end

  end

end


require 'spec_helper'

describe Cupcakinator::Base do

  before :all do
    class CupcakinatorBaseSpecFoo
      include Cupcakinator

      cupcakinate dir: File.expand_path(File.join(File.dirname(__FILE__), '..')), method: 'el_config', file: 'el_config.yml'
    end
  end



  describe 'cupcakinate' do

    # a better way to do this?  It's got the sleep to guarantee a new class name but of course slows it all down
    # a new class name was necessary to ensure clean slate... I tried deregistering the object name, but it seemed
    # like it was not going to bear fruit
    before :each do
      sleep(1)
      @klass = nil
      t = Time.now.strftime("Foo%Y%m%d%H%M%s")
      eval <<-ENDOFKLASS
        class #{t}
          include Cupcakinator
        end
      ENDOFKLASS
      @klass = Object.module_eval(t)
    end


    it 'should call _cupcakinator_options' do
      @klass.should_receive(:_cupcakinator_options).at_least(1).and_return({})

      @klass.cupcakinate method: 'config'
    end

    it 'should set the default config with no options' do
      @klass.cupcakinate

      @klass._cupcakinator_options.should eq Cupcakinator::Options.new
    end

    it 'should merge options into default' do
      @klass.cupcakinate file: 'conf.yml'

      @klass._cupcakinator_options[:file].should == 'conf.yml'
    end

  end


  describe '_cupcakinator_config' do

    it 'should return a Cupcakinator::Config' do
      CupcakinatorBaseSpecFoo._cupcakinator_config.class.should eq(Cupcakinator::Config)
    end

    it 'should return a Cupcakinator::Config for an embedded Hash (in yaml)' do
      CupcakinatorBaseSpecFoo._cupcakinator_config.bacon.class.should eq(Cupcakinator::Config)
    end

    it 'should not load more than once' do
      h = double
      CupcakinatorBaseSpecFoo.instance_variable_set('@cupcakinator_config', h)
      CupcakinatorBaseSpecFoo._cupcakinator_config.should == h
      CupcakinatorBaseSpecFoo.should_not_receive(:load_cupcakinator_config)
    end

  end


  describe 'load_cupcakinator_config' do
    it 'should raise ConfigFileNotFoundError if config file is not found' do
      class CupcakinatorBaseSpecNoExist
        include Cupcakinator

        cupcakinate file: 'no_exist.yml'
      end
      YAML.stub(:load_file).with('./no_exist.yml').and_raise(Errno::ENOENT)
      YAML.stub(:load_file).with(anything).and_call_original

      expect{ CupcakinatorBaseSpecNoExist.load_cupcakinator_config }.to raise_error(Cupcakinator::ConfigFileNotFoundError)
    end

    it 'should raise ConfigFileNotFoundError if config file is not found and allow_missing is true' do
      class CupcakinatorBaseSpecNoExist
        include Cupcakinator

        cupcakinate file: 'no_exist.yml', allow_missing: false
      end
      YAML.stub(:load_file).with('./no_exist.yml').and_raise(Errno::ENOENT)
      YAML.stub(:load_file).with(anything).and_call_original

      expect{ CupcakinatorBaseSpecNoExist.load_cupcakinator_config }.to raise_error(Cupcakinator::ConfigFileNotFoundError)
    end

    it 'should not raise ConfigFileNotFoundError if config file is not found and allow_missing is true' do
      class CupcakinatorBaseSpecNoExist
        include Cupcakinator

        cupcakinate file: 'no_exist.yml', allow_missing: true
      end
      YAML.stub(:load_file).with('./no_exist.yml').and_raise(Errno::ENOENT)
      YAML.stub(:load_file).with(anything).and_call_original

      expect{ CupcakinatorBaseSpecNoExist.load_cupcakinator_config }.to_not raise_error(Cupcakinator::ConfigFileNotFoundError)
    end

    it 'should return empty Config if config file is not found and allow_missing is true' do
      class CupcakinatorBaseSpecNoExist
        include Cupcakinator

        cupcakinate file: 'no_exist.yml', allow_missing: true
      end
      YAML.stub(:load_file).with('./no_exist.yml').and_raise(Errno::ENOENT)
      YAML.stub(:load_file).with(anything).and_call_original

      expect(CupcakinatorBaseSpecNoExist.config.to_h).to eq({})
    end

    it 'should raise ConfigFileInvalidError if config file is not found' do
      dummy = double.as_null_object

      class CupcakinatorBaseSpecBadFile
        include Cupcakinator

        cupcakinate file: 'bad_file.yml'
      end
      YAML.stub(:load_file).with('./bad_file.yml').and_raise(Psych::SyntaxError.new(dummy,dummy,dummy,dummy,dummy,dummy))

      expect{ CupcakinatorBaseSpecBadFile.load_cupcakinator_config }.to raise_error(Cupcakinator::ConfigFileInvalidError)
    end

    it 'should load the YAML anchored at root_key' do
      class CupcakinatorBaseSpecRootKey
        include Cupcakinator

        cupcakinate dir: File.expand_path(File.join(File.dirname(__FILE__), '..')), file: 'el_config.yml', root_key: 'special'
      end

      subject = CupcakinatorBaseSpecRootKey.new
      subject.config.has_key?(:special).should be_false
      subject.config.bacon.chunky.should be_false
    end


  end


  describe 'method missing' do

    let(:subject){ CupcakinatorBaseSpecFoo }

    it 'should use default method missing if not the configured cupcakinator method' do
      expect { subject.doodle }.to raise_error(NoMethodError)
    end

    it 'should not raise if NoMethodError when using the configured cupcakinator method' do
      expect { subject.el_config }.not_to raise_error
    end

    it 'should delegeate to _cupcakinator_config when using the configured cupcakinator method' do
      CupcakinatorBaseSpecFoo.should_receive(:_cupcakinator_config).with('john')

      subject.el_config('john')
    end

  end



  context 'instance methods' do


    describe 'method missing' do

      let(:subject){ CupcakinatorBaseSpecFoo.new }

      it 'should use default method missing if not the configured cupcakinator method' do
        expect { subject.doodle }.to raise_error(NoMethodError)
      end

      it 'should not raise if NoMethodError when using the configured cupcakinator method' do
        expect { subject.el_config }.not_to raise_error
      end

      it 'should delegeate to _cupcakinator_config when using the configured cupcakinator method' do
        CupcakinatorBaseSpecFoo.should_receive(:_cupcakinator_config).with('john')

        subject.el_config('john')
      end

    end


  end

end

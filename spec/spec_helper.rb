require 'rubygems'
require 'spork'

Spork.prefork do
  require 'simplecov'
  SimpleCov.start do
    add_filter "/spec/"
  end

  require 'rspec'

  $LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
  require 'cupcakinator'
end

Spork.each_run do

end
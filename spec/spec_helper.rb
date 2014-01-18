require 'rubygems'
require 'spork'

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'cupcakinator'

Spork.prefork do
  require 'simplecov'
  SimpleCov.start do
    add_filter "/spec/"
  end

  require 'rspec'
end

Spork.each_run do

end
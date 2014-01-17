# cupcakinator [![Build Status](https://travis-ci.org/rubyisbeautiful/cupcakinator.png)](https://travis-ci.org/rubyisbeautiful/cupcakinator) [![Code Climate](https://codeclimate.com/github/rubyisbeautiful/cupcakinator.png)](https://codeclimate.com/github/rubyisbeautiful/cupcakinator)

## Description

cupcakinator provides a simple way to use the 'config' pattern in any class.  For example, given class Foo:

	class Foo
		include Cupcakinator
		
		cupcakinate
	end

and the file ./config/config.yml:
	
	---
	bacon:
		flavor: pork
	meatball:
		flavor:
			- pork
			- chicken
You can do:
	
	>> Foo.config.bacon.flavor
	'pork'
	>> Foo.config.meatball.flavor
	['pork','chicken']
	>> Foo.new.config.bacon.flavor
	'pork'

etc..
Options include dir, file, and method.  	

 
## Installation

Add this line to your application's Gemfile:

    gem 'cupcakinator'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install cupcakinator

## Usage

include Cupcakinator
call 'cupcakinator' in your class with dir, file, and method options

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

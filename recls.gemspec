# ######################################################################## #
# File:     recls.gemspec
#
# Purpose:  Gemspec for recls.Ruby library
#
# Created:  14th February 2014
# Updated:  20th April 2024
#
# ######################################################################## #


$:.unshift File.join(File.dirname(__FILE__), 'lib')

require 'recls'

require 'date'


Gem::Specification.new do |spec|

  spec.name         = 'recls-ruby'
  spec.version      = Recls::VERSION
  spec.date         = Date.today.to_s
  spec.summary      = 'recls.Ruby'
  spec.description  = <<END_DESC
RECursive LS for Ruby
END_DESC
  spec.authors      = [ 'Matt Wilson' ]
  spec.email        = 'matthew@synesis.com.au'
  spec.homepage     = 'http://github.com/synesissoftware/recls.Ruby'
  spec.license      = 'BSD-3-Clause'
  spec.files        = Dir[ 'Rakefile', '{bin,examples,lib,man,spec,test}/**/*', 'README*', 'LICENSE*' ] & `git ls-files -z`.split("\0")

  spec.required_ruby_version = '>= 1.9.3'

  spec.add_development_dependency 'xqsr3', [ '~> 0.31' ]
end


# ############################## end of file ############################# #


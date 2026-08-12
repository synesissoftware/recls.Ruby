# ######################################################################## #
# File:     recls.gemspec
#
# Purpose:  Gemspec for recls.Ruby library
#
# Created:  14th February 2014
# Updated:  13th August 2026
#
# ######################################################################## #


$:.unshift File.join(File.dirname(__FILE__), 'lib')

require 'recls/version'


Gem::Specification.new do |spec|

  spec.name         = 'recls-ruby'
  spec.summary      = 'recls.Ruby'
  spec.version      = Recls::VERSION
  spec.description  = <<END_DESC
RECursive LS for Ruby
END_DESC
  spec.authors      = [ 'Matt Wilson' ]
  spec.email        = 'matthew@synesis.com.au'
  spec.homepage     = 'http://github.com/synesissoftware/recls.Ruby'
  spec.license      = 'BSD-3-Clause'

  spec.required_ruby_version = [ '>= 1.9.3' ]

  spec.add_development_dependency 'xqsr3', [ '~> 0.31' ]

  spec.metadata = {
    'bug_tracker_uri' => 'https://github.com/synesissoftware/recls/issues',
    'changelog_uri' => 'https://github.com/synesissoftware/recls/blob/master/CHANGES.md',
    'homepage_uri' => 'https://github.com/synesissoftware/recls',
    'source_code_uri' => 'https://github.com/synesissoftware/recls',
  }

  spec.files = Dir[
    'Rakefile',
    '{bin,examples,lib,man,spec,test}/**/*',
    'AUTHORS*',
    'CHANGES*',
    'EXAMPLES*',
    'LICENSE*',
    'NEWS*',
    'README*',
    'TODO*',
  ] & `git ls-files -z`.split("\0")
end


# ############################## end of file ############################# #


# ######################################################################## #
# File:     recls-ruby.gemspec
#
# Purpose:  Gemspec for recls.Ruby library
#
# Created:  14th February 2014
# Updated:  19th August 2026
#
# ######################################################################## #


$:.unshift File.join(File.dirname(__FILE__), 'lib')

require 'recls/version'


Gem::Specification.new do |spec|

  spec.name         = 'recls-ruby'
  spec.summary      = 'The platform-independent recursive file-system search library, for Ruby'
  spec.version      = Recls::VERSION
  spec.description  = <<END_DESC
recls.Ruby is a platform-independent recursive file-system search library
for Ruby. It enumerates files and directories (recursively or not),
optionally filtered by wildcards and type flags, and returns each hit as a
rich entry object with path components, type, size, and timestamps
(including Windows-specific attributes where they exist). Path-combination
and existence helpers are included so client code can stay on one API.
The name stands for rec-ursive ls; this gem is the Ruby implementation of
the recls family (also available for C/C++, Go, .NET, Python, and Rust).
END_DESC

  spec.authors      = [
    'Matt Wilson',
  ]
  spec.email        = [
    'matthew@synesis.com.au',
  ]
  spec.homepage     = 'https://github.com/synesissoftware/recls.Ruby'
  spec.license      = 'BSD-3-Clause'

  spec.required_ruby_version = [ '>= 1.9.3' ]

  spec.add_development_dependency "xqsr3", [ '>= 0.39.5', '< 1.0' ]

  spec.metadata = {
    'bug_tracker_uri' => 'https://github.com/synesissoftware/recls.Ruby/issues',
    'changelog_uri' => 'https://github.com/synesissoftware/recls.Ruby/blob/master/CHANGES.md',
    'homepage_uri' => 'https://github.com/synesissoftware/recls.Ruby',
    'source_code_uri' => 'https://github.com/synesissoftware/recls.Ruby',
  }

  spec.files = Dir[
    'Rakefile',
    '{bin,examples,lib,man,spec,test}/**/*',
    'AUTHORS*',
    'CHANGES*',
    'CONTRIBUTING*',
    'EXAMPLES*',
    'FAQ*',
    'INSTALL*',
    'LICENSE*',
    'NEWS*',
    'README*',
    'SECURITY*',
    'TODO*',
  ] & `git ls-files -z`.split("\0")
  spec.files -= [
    '.ruby-version',
    'Gemfile.lock',
  ]
end


# ############################## end of file ############################# #

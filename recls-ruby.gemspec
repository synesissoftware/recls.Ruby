# ######################################################################## #
# File:     recls-ruby.gemspec
#
# Purpose:  Gemspec for recls.Ruby library
#
# Created:  14th February 2014
# Updated:  28th August 2026
#
# ######################################################################## #


$:.unshift File.join(File.dirname(__FILE__), 'lib')

require 'recls/version'


PROJECT_URL = 'https://github.com/synesissoftware/recls.Ruby'


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
  spec.homepage     = PROJECT_URL
  spec.license      = 'BSD-3-Clause'

  spec.required_ruby_version = [ '>= 1.9.3' ]

  spec.metadata = {
    'bug_tracker_uri' => "#{PROJECT_URL}/issues",
    'changelog_uri' => "#{PROJECT_URL}/blob/master/CHANGES.md",
    'homepage_uri' => PROJECT_URL,
    'source_code_uri' => PROJECT_URL,
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

  spec.add_development_dependency "xqsr3", [ '>= 0.39.5', '< 1.0' ]
end


# ############################## end of file ############################# #

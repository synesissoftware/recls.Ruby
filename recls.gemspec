# gemspec for recls

$:.unshift File.join(File.dirname(__FILE__), 'lib')

require 'recls'

require 'date'

Gem::Specification.new do |spec|

	spec.name			=	'recls-ruby'
	spec.version		=	Recls::VERSION
	spec.date			=	Date.today.to_s
	spec.summary		=	'recls.Ruby'
	spec.description	=	<<END_DESC
RECursive LS for Ruby
END_DESC
	spec.authors		=	[ 'Matt Wilson' ]
	spec.email			=	'matthew@synesis.com.au'
	spec.files			=	Dir[ 'Rakefile', '{bin,examples,lib,man,spec,test}/**/*', 'README*', 'LICENSE*' ] & `git ls-files -z`.split("\0")
	spec.homepage		=	'http://recls.org/'
	spec.license		=	'BSD-3-Clause'

	spec.required_ruby_version = '>= 1.9.3'
end


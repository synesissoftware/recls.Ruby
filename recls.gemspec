# gemspec for recls

$:.unshift File.join(File.dirname(__FILE__), 'lib')

require 'recls'

Gem::Specification.new do |gs|

	gs.name			=	'recls'
	gs.version		=	Recls::VERSION
	gs.date			=	Date.today.to_s
	gs.summary		=	'recls.Ruby'
	gs.description	=	'recls Ruby library'
	gs.authors		=	[ 'Matt Wilson' ]
	gs.email		=	'matthew@recls.org'
	gs.files		=	Dir[ 'Rakefile', '{bin,examples,lib,man,spec,test}/**/*', 'README*', 'LICENSE*' ] & `git ls-files -z`.split("\0")
	gs.homepage		=	'http://recls.org/'
	gs.license		=	'Modified BSD'
end


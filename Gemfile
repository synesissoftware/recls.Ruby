# frozen_string_literal: true

source "https://rubygems.org"

# Suppress lockfile on Bundler 4+ (gem: do not pin the graph). No-op on
# Bundler that lacks the DSL (Ruby 2.x CI). Do not combine with
# ruby/setup-ruby `bundler-cache: true` — that action cats Gemfile.lock
# after `bundle lock` and fails when no file is written (Windows 3.2+,
# where setup-ruby installs Bundler ~> 4).
lockfile false if respond_to?(:lockfile)

gemspec

# fiddle left the default-gem set in Ruby 4; Windows (Ruby 2+) requires it
# via lib/recls/ximpl/windows.rb. Not declared in the gemspec: the fiddle
# gem itself requires Ruby >= 2.5 and would break resolution on 1.9.3–2.4.
if Gem::Version.new(RUBY_VERSION) >= Gem::Version.new('4')

  gem "fiddle", '~> 1.0'
end

# rake 13 requires Ruby >= 2.3
if Gem::Version.new(RUBY_VERSION) >= Gem::Version.new("2.3")

  gem "rake", '~> 13.0'
else

  gem "rake", '~> 12.3'
end

gem "test-unit", '~> 3.0'

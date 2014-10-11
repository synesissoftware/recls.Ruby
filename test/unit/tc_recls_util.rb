#! /usr/bin/ruby
#
# test Recls canonicalise_path() method

$:.unshift File.join(File.dirname(__FILE__), '../..', 'lib')


require 'recls/util'

require 'test/unit'

class Test_canonicalise_path < Test::Unit::TestCase

	def test_dots_directories

		assert_equal('.', Recls::canonicalise_path('.'))
		assert_equal('..', Recls::canonicalise_path('..'))

	end # test_dots_directories


	def test_canonicalised_directories_one_level

		assert_equal('abc', Recls::canonicalise_path('abc'))
		assert_equal('abc/', Recls::canonicalise_path('abc/'))
		assert_equal('/abc', Recls::canonicalise_path('/abc'))
		assert_equal('/abc/', Recls::canonicalise_path('/abc/'))

	end # test_canonicalised_directories_one_level

	def test_canonicalised_directories_two_levels

		assert_equal('abc/def', Recls::canonicalise_path('abc/def'))
		assert_equal('abc/def/', Recls::canonicalise_path('abc/def/'))
		assert_equal('/abc/def', Recls::canonicalise_path('/abc/def'))
		assert_equal('/abc/def/', Recls::canonicalise_path('/abc/def/'))

	end # test_canonicalised_directories_two_levels

	def test_uncanonicalised_directories_one_level

		assert_equal('.', Recls::canonicalise_path('.'))
		assert_equal('./', Recls::canonicalise_path('./'))
		assert_equal('/.', Recls::canonicalise_path('/.'))
		assert_equal('/./', Recls::canonicalise_path('/./'))

		assert_equal('..', Recls::canonicalise_path('..'))
		assert_equal('../', Recls::canonicalise_path('../'))
		assert_equal('/..', Recls::canonicalise_path('/..'))
		assert_equal('/../', Recls::canonicalise_path('/../'))

	end # def test_uncanonicalised_directories_one_level

end

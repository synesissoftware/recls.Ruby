
require 'recls/util'

require 'test/unit'

class Test_canonicalisePath < Test::Unit::TestCase

	def test_dots_directories

		assert_equal('.', Recls::canonicalisePath('.'))
		assert_equal('..', Recls::canonicalisePath('..'))

	end # test_dots_directories


	def test_canonicalised_directories_one_level

		assert_equal('abc', Recls::canonicalisePath('abc'))
		assert_equal('abc/', Recls::canonicalisePath('abc/'))
		assert_equal('/abc', Recls::canonicalisePath('/abc'))
		assert_equal('/abc/', Recls::canonicalisePath('/abc/'))

	end # test_canonicalised_directories_one_level

	def test_canonicalised_directories_two_levels

		assert_equal('abc/def', Recls::canonicalisePath('abc/def'))
		assert_equal('abc/def/', Recls::canonicalisePath('abc/def/'))
		assert_equal('/abc/def', Recls::canonicalisePath('/abc/def'))
		assert_equal('/abc/def/', Recls::canonicalisePath('/abc/def/'))

	end # test_canonicalised_directories_two_levels

	def test_uncanonicalised_directories_one_level

		assert_equal('.', Recls::canonicalisePath('.'))
		assert_equal('./', Recls::canonicalisePath('./'))
		assert_equal('/.', Recls::canonicalisePath('/.'))
		assert_equal('/./', Recls::canonicalisePath('/./'))

		assert_equal('..', Recls::canonicalisePath('..'))
		assert_equal('../', Recls::canonicalisePath('../'))
		assert_equal('/..', Recls::canonicalisePath('/..'))
		assert_equal('/../', Recls::canonicalisePath('/../'))

	end # def test_uncanonicalised_directories_one_level

end


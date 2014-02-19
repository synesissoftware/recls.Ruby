
require 'recls'

require 'test/unit'

class Test_Recls_constants < Test::Unit::TestCase

	private
	@@OS_IS_WINDOWS = Recls::Ximpl::OS::OS_IS_WINDOWS

	public


	def test_PATH_NAME_SEPARATOR

		expected = @@OS_IS_WINDOWS ? '\\' : '/'

		assert_equal(expected, Recls::PATH_NAME_SEPARATOR)

	end # def test_PATH_NAME_SEPARATOR

  if not defined? RECLS_NO_OBSOLETE

	def test_pathNameSeparator

		assert_equal(Recls::PATH_NAME_SEPARATOR, Recls::pathNameSeparator)

	end # def test_pathNameSeparator

  end

	def test_PATH_SEPARATOR

		expected = @@OS_IS_WINDOWS ? ';' : ':'

		assert_equal(expected, Recls::PATH_SEPARATOR)

	end # def test_PATH_SEPARATOR

  if not defined? RECLS_NO_OBSOLETE

	def test_pathSeparator

		assert_equal(Recls::PATH_SEPARATOR, Recls::pathSeparator)

	end # def test_pathSeparator

  end



	def test_WILDCARDS_ALL

		#expected = @@OS_IS_WINDOWS ? '*.*' : '*'

		assert_equal('*', Recls::WILDCARDS_ALL)

	end # def test_WILDCARDS_ALL

  if not defined? RECLS_NO_OBSOLETE

	def test_wildcardsAll

		assert_equal(Recls::WILDCARDS_ALL, Recls::wildcardsAll)

	end # def test_wildcardsAll

  end

end



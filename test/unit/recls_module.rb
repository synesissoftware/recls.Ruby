
require 'recls'

require 'test/unit'

class Test_Recls_constants < Test::Unit::TestCase

	private
	@@OS_IS_WINDOWS = Recls::Ximpl::OS::OS_IS_WINDOWS

	public

	def test_wildcards_all

		expected = @@OS_IS_WINDOWS ? "*.*" : "*"

		assert_equal(expected, Recls::wildcards_all)

	end # def test_wildcards_all

  if not defined? RECLS_NO_OBSOLETE

	def test_wildcardsAll

		assert_equal(Recls::wildcards_all, Recls::wildcardsAll)

	end # def test_wildcardsAll

  end

end



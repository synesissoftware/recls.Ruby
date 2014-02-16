
require 'recls/util'

require 'test/unit'

class Test_canonicalisePath < Test::Unit::TestCase

	def test_dots_directories

		assert_equal('.', Recls::canonicalisePath('.'))
		assert_equal('..', Recls::canonicalisePath('..'))

	end

end


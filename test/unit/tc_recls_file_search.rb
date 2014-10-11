#! /usr/bin/ruby
#
# test Recls.FileSearch class

$:.unshift File.join(File.dirname(__FILE__), '../..', 'lib')


require 'recls'

require 'test/unit'

class Test_Recls_FileSearch_class < Test::Unit::TestCase

	def test_construction

		fs = Recls::FileSearch::new(nil, nil, 0)

		assert_not_nil(fs)

	end # def test_construction

	def test_construction_1

		fs = Recls::FileSearch::new('abc', '*c', Recls::FILES)

		assert_not_nil(fs)
		assert_equal('abc', fs.search_root)
		assert_equal(['*c'], fs.patterns)
  if not defined? RECLS_NO_OBSOLETE
		assert_equal('abc', fs.searchRoot)
		assert_equal(['*c'], fs.pattern)
  end
		assert_equal(Recls::FILES, fs.flags)

	end # def test_construction_1

	def test_construction_2

		fs = Recls::FileSearch::new('def', '*c', 0)

		assert_not_nil(fs)
		assert_equal('def', fs.search_root)
		assert_equal(['*c'], fs.patterns)
  if not defined? RECLS_NO_OBSOLETE
		assert_equal('def', fs.searchRoot)
		assert_equal(['*c'], fs.pattern)
  end
		assert_equal(Recls::FILES, fs.flags)

	end # def test_construction_2

	def test_construction_3

		fs = Recls::FileSearch::new('ghi', '*c', Recls::DIRECTORIES)

		assert_not_nil(fs)
		assert_equal('ghi', fs.search_root)
		assert_equal(['*c'], fs.patterns)
  if not defined? RECLS_NO_OBSOLETE
		assert_equal('ghi', fs.searchRoot)
		assert_equal(['*c'], fs.pattern)
  end
		assert_equal(Recls::DIRECTORIES, fs.flags)

	end # def test_construction_3

end


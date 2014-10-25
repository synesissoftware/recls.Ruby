#! /usr/bin/ruby
#
# test Recls canonicalise_path() method

$:.unshift File.join(File.dirname(__FILE__), '../..', 'lib')


require 'recls/util'

require 'test/unit'

class Test_canonicalise_path < Test::Unit::TestCase



	def test_nil

		assert_nil(Recls::canonicalise_path(nil))

	end

	def test_empty

		assert_equal('', Recls::canonicalise_path(''))

	end

	def test_dots_directories

		assert_equal('.', Recls::canonicalise_path('.'))
		assert_equal('./', Recls::canonicalise_path('./'))
		assert_equal('.', Recls::canonicalise_path('././.'))
		assert_equal('./', Recls::canonicalise_path('./././'))

		assert_equal('..', Recls::canonicalise_path('..'))
		assert_equal('../', Recls::canonicalise_path('../'))
		assert_equal('..', Recls::canonicalise_path('../.'))
		assert_equal('../', Recls::canonicalise_path('.././'))

	end

	def test_files_only

		assert_equal('a', Recls::canonicalise_path('a'))
		assert_equal('file', Recls::canonicalise_path('file'))
		assert_equal('file.ext', Recls::canonicalise_path('file.ext'))

	end

	def test_zero_parts

		if Recls::Ximpl::OS::OS_IS_WINDOWS

			assert_equal('H:', Recls::canonicalise_path('H:'))

			assert_equal('\\\\server', Recls::canonicalise_path('\\\\server'))
			assert_equal('\\\\server\\', Recls::canonicalise_path('\\\\server\\'))
			assert_equal('\\\\server\\share', Recls::canonicalise_path('\\\\server\\share'))
			assert_equal('\\\\server\\share/', Recls::canonicalise_path('\\\\server\\share/'))

		end

	end

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
		assert_equal('/', Recls::canonicalise_path('/.'))
		assert_equal('/', Recls::canonicalise_path('/./'))

		assert_equal('..', Recls::canonicalise_path('..'))
		assert_equal('../', Recls::canonicalise_path('../'))
		assert_equal('/', Recls::canonicalise_path('/..'))
		assert_equal('/', Recls::canonicalise_path('/../'))

	end # def test_uncanonicalised_directories_one_level

	def test_single_canonicalisation

		assert_equal('dir.1/', Recls::canonicalise_path('dir.1/'))
		assert_equal('dir.1/', Recls::canonicalise_path('dir.1/./'))
		assert_equal('dir.1/', Recls::canonicalise_path('./dir.1/./'))
		assert_equal('dir.1/', Recls::canonicalise_path('./dir.1/.'))

	end

	def test_double_canonicalisation

		assert_equal('dir.1/dir.2/', Recls::canonicalise_path('dir.1/dir.2/'))
		assert_equal('dir.1/dir.2/', Recls::canonicalise_path('dir.1/dir.2/dir.3/../'))
		assert_equal('dir.1/dir.2/', Recls::canonicalise_path('dir.1/dir.2/dir.3/../'))
		assert_equal('dir.1/dir.2/', Recls::canonicalise_path('dir.1/dir.3/../dir.2/'))
		assert_equal('dir.1/dir.2/', Recls::canonicalise_path('dir.3/../dir.1/dir.2/'))

		assert_equal('../dir.1/dir.2/', Recls::canonicalise_path('../dir.1/dir.2/'))
		assert_equal('../dir.4/', Recls::canonicalise_path('../dir.1/../dir.4/'))

		assert_equal('/dir.1/dir.2/', Recls::canonicalise_path('/dir.1/dir.2/'))
		assert_equal('/dir.1/dir.2/', Recls::canonicalise_path('/dir.1/dir.2/dir.3/../'))
		assert_equal('/dir.1/dir.2/', Recls::canonicalise_path('/dir.1/dir.2/dir.3/../'))
		assert_equal('/dir.1/dir.2/', Recls::canonicalise_path('/dir.1/dir.3/../dir.2/'))
		assert_equal('/dir.1/dir.2/', Recls::canonicalise_path('/dir.3/../dir.1/dir.2/'))

		assert_equal('/dir.1/dir.2/', Recls::canonicalise_path('/../dir.1/dir.2/'))
		assert_equal('/dir.4/', Recls::canonicalise_path('/../dir.1/../dir.4/'))

		assert_equal('/dir.14/', Recls::canonicalise_path('/dir.14/dir.2/..'))
		assert_equal('/', Recls::canonicalise_path('/dir.14/dir.2/../..'))
		assert_equal('/', Recls::canonicalise_path('/dir.14/dir.2/../../..'))
		assert_equal('dir.14/', Recls::canonicalise_path('dir.14/dir.2/..'))
		assert_equal('.', Recls::canonicalise_path('dir.14/dir.2/../..'))
		assert_equal('..', Recls::canonicalise_path('dir.14/dir.2/../../..'))

		if Recls::Ximpl::OS::OS_IS_WINDOWS

			assert_equal('H:\\dir.1\\dir.2\\', Recls::canonicalise_path('H:\\dir.1\\dir.2\\'))
			assert_equal('H:\\dir.1\\dir.2\\', Recls::canonicalise_path('H:\\dir.1\\dir.2\\dir.3\\..\\'))
			assert_equal('H:\\dir.1\\dir.2\\', Recls::canonicalise_path('H:\\dir.1\\dir.2\\dir.3\\..\\'))
			assert_equal('H:\\dir.1\\dir.2\\', Recls::canonicalise_path('H:\\dir.1\\dir.3\\..\\dir.2\\'))
			assert_equal('H:\\dir.1\\dir.2\\', Recls::canonicalise_path('H:\\dir.3\\..\\dir.1\\dir.2\\'))

			assert_equal('H:\\..\\dir.43\\dir.5\\', Recls::canonicalise_path('H:\\..\\dir.43\\dir.5\\'))
			assert_equal('H:\\..\\dir.42\\', Recls::canonicalise_path('H:\\..\\dir.1\\..\\dir.42\\'))

		end

	end

	def test_complex_examples

		assert_equal('../dir.11/dir.22/dir.33/file3.', Recls::canonicalise_path('abc/.././././.././dir.1/../dir.11/dir.22/dir.33/file3.'))
		assert_equal('/dir.11/dir.22/dir.33/file3.', Recls::canonicalise_path('/abc/.././././.././dir.1/../dir.11/dir.22/dir.33/file3.'))
		assert_equal('../dir.11/dir.22/dir.33/file3.', Recls::canonicalise_path('./././abc/.././././.././dir.1/../dir.11/dir.22/././dir.33/././file3.'))

		if Recls::Ximpl::OS::OS_IS_WINDOWS

		end

	end

end


#! /usr/bin/env ruby
#
# test Recls::Ximpl::Util namespace

$:.unshift File.join(File.dirname(__FILE__), '../..', 'lib')


require 'recls'

require 'test/unit'

class Test_Recls_Ximpl_Util_get_windows_root < Test::Unit::TestCase

	def test_nil

		wr, rem = Recls::Ximpl::Util.get_windows_root(nil)
		assert_nil(wr)
		assert_nil(rem)

	end

	def test_empty

		wr, rem = Recls::Ximpl::Util.get_windows_root('')
		assert_nil(wr)
		assert_equal('', rem)

	end

	def test_dots_directories

		wr, rem = Recls::Ximpl::Util.get_windows_root('.')
		assert_nil(wr)
		assert_not_nil(rem)
		assert_equal('.', rem)

		wr, rem = Recls::Ximpl::Util.get_windows_root('..')
		assert_nil(wr)
		assert_not_nil(rem)
		assert_equal('..', rem)

	end

	def test_relative_paths

		wr, rem = Recls::Ximpl::Util.get_windows_root('a')
		assert_nil(wr)
		assert_not_nil(rem)
		assert_equal('a', rem)

		wr, rem = Recls::Ximpl::Util.get_windows_root('dir1')
		assert_nil(wr)
		assert_not_nil(rem)
		assert_equal('dir1', rem)

		wr, rem = Recls::Ximpl::Util.get_windows_root('dir1/dir2')
		assert_nil(wr)
		assert_not_nil(rem)
		assert_equal('dir1/dir2', rem)

	end

	def test_windows_paths

		if Recls::Ximpl::OS::OS_IS_WINDOWS

			# drive only
			wr, rem = Recls::Ximpl::Util.get_windows_root('H:')
			assert_not_nil(wr)
			assert_equal('H:', wr)
			assert_not_nil(rem)
			assert_equal('', rem)

			# drive and root directory
			wr, rem = Recls::Ximpl::Util.get_windows_root('H:\\')
			assert_not_nil(wr)
			assert_equal('H:', wr)
			assert_not_nil(rem)
			assert_equal('\\', rem)

			# drive and rooted sub-directory
			wr, rem = Recls::Ximpl::Util.get_windows_root('H:\\dir1')
			assert_not_nil(wr)
			assert_equal('H:', wr)
			assert_not_nil(rem)
			assert_equal('\\dir1', rem)

			# drive and unrooted sub-directory
			wr, rem = Recls::Ximpl::Util.get_windows_root('H:dir1')
			assert_not_nil(wr)
			assert_equal('H:', wr)
			assert_not_nil(rem)
			assert_equal('dir1', rem)

			# UNC with server only
			wr, rem = Recls::Ximpl::Util.get_windows_root('\\\\server')
			assert_not_nil(wr)
			assert_equal('\\\\server', wr)
			assert_nil(rem)

			# UNC with server and slash
			wr, rem = Recls::Ximpl::Util.get_windows_root('\\\\server\\')
			assert_not_nil(wr)
			assert_equal('\\\\server\\', wr)
			assert_nil(rem)

			# UNC with server and drive only
			wr, rem = Recls::Ximpl::Util.get_windows_root('\\\\server\\share')
			assert_not_nil(wr)
			assert_equal('\\\\server\\share', wr)
			assert_nil(rem)

			# UNC full drive with root directory
			wr, rem = Recls::Ximpl::Util.get_windows_root('\\\\server\\share\\')
			assert_not_nil(wr)
			assert_equal('\\\\server\\share', wr)
			assert_equal('\\', rem)

			wr, rem = Recls::Ximpl::Util.get_windows_root('\\\\server\\share/')
			assert_not_nil(wr)
			assert_equal('\\\\server\\share', wr)
			assert_equal('/', rem)

		end

	end

end

class Test_Recls_Ximpl_Util_split_path < Test::Unit::TestCase

	def test_nil

		wr, dir, bn, no, ex = Recls::Ximpl::Util::split_path(nil)
		assert_nil(wr)
		assert_nil(dir)
		assert_nil(bn)
		assert_nil(no)
		assert_nil(ex)

	end

	def test_empty

		wr, dir, bn, no, ex = Recls::Ximpl::Util::split_path('')
		assert_nil(wr)
		assert_nil(dir)
		assert_nil(bn)
		assert_nil(no)
		assert_nil(ex)

	end

	def test_name_only

		wr, dir, bn, no, ex = Recls::Ximpl::Util::split_path('a')
		assert_nil(wr)
		assert_nil(dir)
		assert_equal('a', bn)
		assert_equal('a', no)
		assert_nil(ex)

		wr, dir, bn, no, ex = Recls::Ximpl::Util::split_path('abc')
		assert_nil(wr)
		assert_nil(dir)
		assert_equal('abc', bn)
		assert_equal('abc', no)
		assert_nil(ex)

		wr, dir, bn, no, ex = Recls::Ximpl::Util::split_path('a_slightly-long_file-name')
		assert_nil(wr)
		assert_nil(dir)
		assert_equal('a_slightly-long_file-name', bn)
		assert_equal('a_slightly-long_file-name', no)
		assert_nil(ex)

	end

	def test_name_and_extensions

		wr, dir, bn, no, ex = Recls::Ximpl::Util::split_path('a.b')
		assert_nil(wr)
		assert_nil(dir)
		assert_equal('a.b', bn)
		assert_equal('a', no)
		assert_equal('.b', ex)

		wr, dir, bn, no, ex = Recls::Ximpl::Util::split_path('a.b.c')
		assert_nil(wr)
		assert_nil(dir)
		assert_equal('a.b.c', bn)
		assert_equal('a.b', no)
		assert_equal('.c', ex)

	end

	def test_directory_only

		wr, dir, bn, no, ex = Recls::Ximpl::Util::split_path('a.b/')
		assert_nil(wr)
		assert_equal('a.b/', dir)
		assert_nil(bn)
		assert_nil(no)
		assert_nil(ex)

		wr, dir, bn, no, ex = Recls::Ximpl::Util::split_path('a.b.c/')
		assert_nil(wr)
		assert_equal('a.b.c/', dir)
		assert_nil(bn)
		assert_nil(no)
		assert_nil(ex)

		wr, dir, bn, no, ex = Recls::Ximpl::Util::split_path('dir1/dir2/a.b/')
		assert_nil(wr)
		assert_equal('dir1/dir2/a.b/', dir)
		assert_nil(bn)
		assert_nil(no)
		assert_nil(ex)

		wr, dir, bn, no, ex = Recls::Ximpl::Util::split_path('/dir1/dir2/a.b/')
		assert_nil(wr)
		assert_equal('/dir1/dir2/a.b/', dir)
		assert_nil(bn)
		assert_nil(no)
		assert_nil(ex)

		wr, dir, bn, no, ex = Recls::Ximpl::Util::split_path('/')
		assert_nil(wr)
		assert_equal('/', dir)
		assert_nil(bn)
		assert_nil(no)
		assert_nil(ex)

	end

	def test_directory_and_name_only

		wr, dir, bn, no, ex = Recls::Ximpl::Util::split_path('dir1/dir2/file3')
		assert_nil(wr)
		assert_equal('dir1/dir2/', dir)
		assert_equal('file3', bn)
		assert_equal('file3', no)
		assert_nil(ex)

		wr, dir, bn, no, ex = Recls::Ximpl::Util::split_path('/dir1/dir2/file3')
		assert_nil(wr)
		assert_equal('/dir1/dir2/', dir)
		assert_equal('file3', bn)
		assert_equal('file3', no)
		assert_nil(ex)

		wr, dir, bn, no, ex = Recls::Ximpl::Util::split_path('/dir.1/dir.2/file.3')
		assert_nil(wr)
		assert_equal('/dir.1/dir.2/', dir)
		assert_equal('file.3', bn)
		assert_equal('file', no)
		assert_equal('.3', ex)

	end

	if Recls::Ximpl::OS::OS_IS_WINDOWS

		def test_Windows_root

			wr, dir, bn, no, ex = Recls::Ximpl::Util::split_path('H:')
			assert_equal('H:', wr)
			assert_nil(dir)
			assert_nil(bn)
			assert_nil(no)
			assert_nil(ex)

			wr, dir, bn, no, ex = Recls::Ximpl::Util::split_path('H:\\')
			assert_equal('H:', wr)
			assert_equal('\\', dir)
			assert_nil(bn)
			assert_nil(no)
			assert_nil(ex)

			wr, dir, bn, no, ex = Recls::Ximpl::Util::split_path('H:/')
			assert_equal('H:', wr)
			assert_equal('/', dir)
			assert_nil(bn)
			assert_nil(no)
			assert_nil(ex)

			wr, dir, bn, no, ex = Recls::Ximpl::Util::split_path('H:/file.3')
			assert_equal('H:', wr)
			assert_equal('/', dir)
			assert_equal('file.3', bn)
			assert_equal('file', no)
			assert_equal('.3', ex)

			wr, dir, bn, no, ex = Recls::Ximpl::Util::split_path('H:file.3')
			assert_equal('H:', wr)
			assert_nil(dir)
			assert_equal('file.3', bn)
			assert_equal('file', no)
			assert_equal('.3', ex)

			wr, dir, bn, no, ex = Recls::Ximpl::Util::split_path('H:/dir.1\\dir.2/file.3')
			assert_equal('H:', wr)
			assert_equal('/dir.1\\dir.2/', dir)
			assert_equal('file.3', bn)
			assert_equal('file', no)
			assert_equal('.3', ex)

			wr, dir, bn, no, ex = Recls::Ximpl::Util::split_path('H:/dir.1\\dir.2/file.')
			assert_equal('H:', wr)
			assert_equal('/dir.1\\dir.2/', dir)
			assert_equal('file.', bn)
			assert_equal('file', no)
			assert_equal('.', ex)

		end

	end

end

class Test_Recls_Ximpl_basename < Test::Unit::TestCase

	def test_basename_with_paths_without_directories

		assert_equal('a', Recls::Ximpl::basename('a'))
		assert_equal('abc', Recls::Ximpl::basename('abc'))
		assert_equal('abc.def', Recls::Ximpl::basename('abc.def'))

	end # def test_basename_with_paths_without_directories

	def test_basename_with_paths_with_only_directories

		assert_equal('', Recls::Ximpl::basename('a/'))
		assert_equal('', Recls::Ximpl::basename('abc/def/'))
		assert_equal('', Recls::Ximpl::basename('dir.1/dir2./'))

		if Recls::Ximpl::OS::OS_IS_WINDOWS

			assert_equal('', Recls::Ximpl::basename('H:\\'))
			assert_equal('', Recls::Ximpl::basename('H:/'))
			assert_equal('', Recls::Ximpl::basename('H:\\dir1\\'))
			assert_equal('', Recls::Ximpl::basename('H:/dir1/'))

			assert_equal('', Recls::Ximpl::basename('\\\\server\\share\\dir1/dir2\\'))
			assert_equal('', Recls::Ximpl::basename('\\\\server\\share/dir1\\dir2/'))

			assert_equal('', Recls::Ximpl::basename('\\\\server\\share\\dir1/'))
			assert_equal('', Recls::Ximpl::basename('\\\\server\\share/dir1\\'))

			assert_equal('', Recls::Ximpl::basename('\\\\server\\share\\'))
			assert_equal('', Recls::Ximpl::basename('\\\\server\\share/'))

			assert_equal('', Recls::Ximpl::basename('\\\\server\\share'))
			assert_equal('', Recls::Ximpl::basename('\\\\server\\share'))

			assert_equal('', Recls::Ximpl::basename('\\\\server\\'))
			assert_equal('', Recls::Ximpl::basename('\\\\server\\'))

			assert_equal('', Recls::Ximpl::basename('\\\\server'))
			assert_equal('', Recls::Ximpl::basename('\\\\server'))

		end

	end # def test_basename_with_paths_with_only_directories

	def test_basename_with_paths_with_directories

		assert_equal('file2', Recls::Ximpl::basename('dir1/file2'))
		assert_equal('file.2', Recls::Ximpl::basename('dir.1/file.2'))
		assert_equal('b.c', Recls::Ximpl::basename('a/b.c'))
		assert_equal('ghi.jkl', Recls::Ximpl::basename('abc/def/ghi.jkl'))
		assert_equal('file3.', Recls::Ximpl::basename('dir.1/dir2./file3.'))

		if Recls::Ximpl::OS::OS_IS_WINDOWS

			assert_equal('file1', Recls::Ximpl::basename('H:\\file1'))
			assert_equal('file1', Recls::Ximpl::basename('H:/file1'))
			assert_equal('file1', Recls::Ximpl::basename('H:\\dir1\\file1'))
			assert_equal('file1', Recls::Ximpl::basename('H:/dir1/file1'))

			assert_equal('file1', Recls::Ximpl::basename('\\\\server\\share\\dir1/dir2\\file1'))
			assert_equal('file1', Recls::Ximpl::basename('\\\\server\\share/dir1\\dir2/file1'))

			assert_equal('file1', Recls::Ximpl::basename('\\\\server\\share\\dir1/file1'))
			assert_equal('file1', Recls::Ximpl::basename('\\\\server\\share/dir1\\file1'))

			assert_equal('file1', Recls::Ximpl::basename('\\\\server\\share\\file1'))
			assert_equal('file1', Recls::Ximpl::basename('\\\\server\\share/file1'))

		end

	end # def test_basename_with_paths_with_directories

end

class Test_Recls_Ximpl_file_ext < Test::Unit::TestCase

	def test_paths_without_files

		assert_equal('', Recls::Ximpl::file_ext(''))
		assert_equal('', Recls::Ximpl::file_ext('/'))
		assert_equal('', Recls::Ximpl::file_ext('/dir1/'))
		assert_equal('', Recls::Ximpl::file_ext('/dir.1/'))
		assert_equal('', Recls::Ximpl::file_ext('/dir1/dir2/'))
		assert_equal('', Recls::Ximpl::file_ext('/dir.1/dir2/'))

		if Recls::Ximpl::OS::OS_IS_WINDOWS

			assert_equal('', Recls::Ximpl::file_ext('H:'))
			assert_equal('', Recls::Ximpl::file_ext('H:/'))
			assert_equal('', Recls::Ximpl::file_ext('H:\\'))

			assert_equal('', Recls::Ximpl::file_ext('\\\\server\\share\\dir1/dir2\\'))
			assert_equal('', Recls::Ximpl::file_ext('\\\\server\\share/dir1\\dir2/'))

		end

	end

	def test_paths_with_files_but_no_extensions

		assert_equal('', Recls::Ximpl::file_ext('file3'))
		assert_equal('', Recls::Ximpl::file_ext('/file3'))
		assert_equal('', Recls::Ximpl::file_ext('/dir1/file3'))
		assert_equal('', Recls::Ximpl::file_ext('/dir.1/file3'))
		assert_equal('', Recls::Ximpl::file_ext('/dir1/dir2/file3'))
		assert_equal('', Recls::Ximpl::file_ext('/dir.1/dir2/file3'))

		if Recls::Ximpl::OS::OS_IS_WINDOWS

			assert_equal('', Recls::Ximpl::file_ext('H:file3'))
			assert_equal('', Recls::Ximpl::file_ext('H:/file3'))
			assert_equal('', Recls::Ximpl::file_ext('H:\\file3'))

			assert_equal('', Recls::Ximpl::file_ext('\\\\server\\share\\dir1/dir2\\file3'))
			assert_equal('', Recls::Ximpl::file_ext('\\\\server\\share/dir1\\dir2/file3'))

		end

	end

	def test_paths_with_files_with_extensions

		assert_equal('.ext', Recls::Ximpl::file_ext('file3.ext'))
		assert_equal('.ext', Recls::Ximpl::file_ext('/file3.ext'))
		assert_equal('.ext', Recls::Ximpl::file_ext('/dir1/file3.ext'))
		assert_equal('.ext', Recls::Ximpl::file_ext('/dir.1/file3.ext'))
		assert_equal('.ext', Recls::Ximpl::file_ext('/dir1/dir2/file3.ext'))
		assert_equal('.ext', Recls::Ximpl::file_ext('/dir.1/dir2/file3.ext'))

		if Recls::Ximpl::OS::OS_IS_WINDOWS

			assert_equal('.ext', Recls::Ximpl::file_ext('H:file3.ext'))
			assert_equal('.ext', Recls::Ximpl::file_ext('H:/file3.ext'))
			assert_equal('.ext', Recls::Ximpl::file_ext('H:\\file3.ext'))

			assert_equal('.ext', Recls::Ximpl::file_ext('\\\\server\\share\\dir1/dir2\\file3.ext'))
			assert_equal('.ext', Recls::Ximpl::file_ext('\\\\server\\share/dir1\\dir2/file3.ext'))

		end

	end

end

class Test_Recls_Ximpl_directory_from_directory_path < Test::Unit::TestCase

	def test_nil

		assert_nil(Recls::Ximpl::directory_from_directory_path(nil))

	end

	def test_empty

		assert_equal('', Recls::Ximpl::directory_from_directory_path(''))

	end

	def test_dots

		assert_equal('.', Recls::Ximpl::directory_from_directory_path('.'))

	end

	def test_leaf_dir_only

		assert_equal('dir', Recls::Ximpl::directory_from_directory_path('dir'))
		assert_equal('dir.ext', Recls::Ximpl::directory_from_directory_path('dir.ext'))
		assert_equal('dir.', Recls::Ximpl::directory_from_directory_path('dir.'))

	end

	def test_roots_only

		assert_equal('/', Recls::Ximpl::directory_from_directory_path('/'))

		if Recls::Ximpl::OS::OS_IS_WINDOWS

			assert_equal('\\', Recls::Ximpl::directory_from_directory_path('H:\\'))
			assert_equal('\\', Recls::Ximpl::directory_from_directory_path('\\\\server\\share\\'))
			assert_equal('/', Recls::Ximpl::directory_from_directory_path('H:/'))
			assert_equal('/', Recls::Ximpl::directory_from_directory_path('\\\\server\\share/'))

		end

	end

	def test_rooted_paths

		if Recls::Ximpl::OS::OS_IS_WINDOWS

			assert_equal('\\dir.1\\dir.2', Recls::Ximpl::directory_from_directory_path('H:\\dir.1\\dir.2'))
			assert_equal('\\dir.1\\dir.2\\', Recls::Ximpl::directory_from_directory_path('H:\\dir.1\\dir.2\\'))

		end

	end

end

class Test_Recls_Ximpl_canonicalise_path < Test::Unit::TestCase

	def test_nil

		assert_nil(Recls::Ximpl::canonicalise_path(nil))

	end

	def test_empty

		assert_equal('', Recls::Ximpl::canonicalise_path(''))

	end

	def test_dots_directories

		assert_equal('.', Recls::Ximpl::canonicalise_path('.'))
		assert_equal('./', Recls::Ximpl::canonicalise_path('./'))
		assert_equal('.', Recls::Ximpl::canonicalise_path('././.'))
		assert_equal('./', Recls::Ximpl::canonicalise_path('./././'))

		assert_equal('..', Recls::Ximpl::canonicalise_path('..'))
		assert_equal('../', Recls::Ximpl::canonicalise_path('../'))
		assert_equal('..', Recls::Ximpl::canonicalise_path('../.'))
		assert_equal('../', Recls::Ximpl::canonicalise_path('.././'))

	end

	def test_files_only

		assert_equal('a', Recls::Ximpl::canonicalise_path('a'))
		assert_equal('file', Recls::Ximpl::canonicalise_path('file'))
		assert_equal('file.ext', Recls::Ximpl::canonicalise_path('file.ext'))

	end

	def test_zero_parts

		if Recls::Ximpl::OS::OS_IS_WINDOWS

			assert_equal('H:', Recls::Ximpl::canonicalise_path('H:'))

			assert_equal('\\\\server', Recls::Ximpl::canonicalise_path('\\\\server'))
			assert_equal('\\\\server\\', Recls::Ximpl::canonicalise_path('\\\\server\\'))
			assert_equal('\\\\server\\share', Recls::Ximpl::canonicalise_path('\\\\server\\share'))
			assert_equal('\\\\server\\share/', Recls::Ximpl::canonicalise_path('\\\\server\\share/'))

		end

	end

	def test_single_canonicalisation

		assert_equal('dir.1/', Recls::Ximpl::canonicalise_path('dir.1/'))
		assert_equal('dir.1/', Recls::Ximpl::canonicalise_path('dir.1/./'))
		assert_equal('dir.1/', Recls::Ximpl::canonicalise_path('./dir.1/./'))
		assert_equal('dir.1/', Recls::Ximpl::canonicalise_path('./dir.1/.'))

	end

	def test_double_canonicalisation

		assert_equal('dir.1/dir.2/', Recls::Ximpl::canonicalise_path('dir.1/dir.2/'))
		assert_equal('dir.1/dir.2/', Recls::Ximpl::canonicalise_path('dir.1/dir.2/dir.3/../'))
		assert_equal('dir.1/dir.2/', Recls::Ximpl::canonicalise_path('dir.1/dir.2/dir.3/../'))
		assert_equal('dir.1/dir.2/', Recls::Ximpl::canonicalise_path('dir.1/dir.3/../dir.2/'))
		assert_equal('dir.1/dir.2/', Recls::Ximpl::canonicalise_path('dir.3/../dir.1/dir.2/'))

		assert_equal('../dir.1/dir.2/', Recls::Ximpl::canonicalise_path('../dir.1/dir.2/'))
		assert_equal('../dir.4/', Recls::Ximpl::canonicalise_path('../dir.1/../dir.4/'))

		assert_equal('/dir.1/dir.2/', Recls::Ximpl::canonicalise_path('/dir.1/dir.2/'))
		assert_equal('/dir.1/dir.2/', Recls::Ximpl::canonicalise_path('/dir.1/dir.2/dir.3/../'))
		assert_equal('/dir.1/dir.2/', Recls::Ximpl::canonicalise_path('/dir.1/dir.2/dir.3/../'))
		assert_equal('/dir.1/dir.2/', Recls::Ximpl::canonicalise_path('/dir.1/dir.3/../dir.2/'))
		assert_equal('/dir.1/dir.2/', Recls::Ximpl::canonicalise_path('/dir.3/../dir.1/dir.2/'))

		assert_equal('/dir.1/dir.2/', Recls::Ximpl::canonicalise_path('/../dir.1/dir.2/'))
		assert_equal('/dir.4/', Recls::Ximpl::canonicalise_path('/../dir.1/../dir.4/'))

		assert_equal('/dir.14/', Recls::Ximpl::canonicalise_path('/dir.14/dir.2/..'))
		assert_equal('dir.14/', Recls::Ximpl::canonicalise_path('dir.14/dir.2/..'))

		assert_equal('/', Recls::Ximpl::canonicalise_path('/dir.14/dir.2/../..'))
		assert_equal('.', Recls::Ximpl::canonicalise_path('dir.14/dir.2/../..'))

		if Recls::Ximpl::OS::OS_IS_WINDOWS

			assert_equal('H:\\dir.1\\dir.2\\', Recls::Ximpl::canonicalise_path('H:\\dir.1\\dir.2\\'))
			assert_equal('H:\\dir.1\\dir.2\\', Recls::Ximpl::canonicalise_path('H:\\dir.1\\dir.2\\dir.3\\..\\'))
			assert_equal('H:\\dir.1\\dir.2\\', Recls::Ximpl::canonicalise_path('H:\\dir.1\\dir.2\\dir.3\\..\\'))
			assert_equal('H:\\dir.1\\dir.2\\', Recls::Ximpl::canonicalise_path('H:\\dir.1\\dir.3\\..\\dir.2\\'))
			assert_equal('H:\\dir.1\\dir.2\\', Recls::Ximpl::canonicalise_path('H:\\dir.3\\..\\dir.1\\dir.2\\'))

			assert_equal('H:\\dir.43\\dir.5\\', Recls::Ximpl::canonicalise_path('H:\\..\\dir.43\\dir.5\\'))
			assert_equal('H:\\dir.42\\', Recls::Ximpl::canonicalise_path('H:\\..\\dir.1\\..\\dir.42\\'))

		end

	end

	def test_complex_examples

		assert_equal('../dir.11/dir.22/dir.33/file3.', Recls::Ximpl::canonicalise_path('abc/.././././.././dir.1/../dir.11/dir.22/dir.33/file3.'))
		assert_equal('/dir.11/dir.22/dir.33/file3.', Recls::Ximpl::canonicalise_path('/abc/.././././.././dir.1/../dir.11/dir.22/dir.33/file3.'))
		assert_equal('../dir.11/dir.22/dir.33/file3.', Recls::Ximpl::canonicalise_path('./././abc/.././././.././dir.1/../dir.11/dir.22/././dir.33/././file3.'))

		if Recls::Ximpl::OS::OS_IS_WINDOWS

		end

	end

end

class Test_Recls_Ximpl_absolute_path < Test::Unit::TestCase

	attr_reader :cwd

	def setup

		@cwd = Dir.getwd

	end

	def test_nil

		assert_nil(Recls::Ximpl::absolute_path(nil))

		assert_nil(Recls::Ximpl::absolute_path(nil, cwd))

	end

	def test_empty_path

		assert_equal('', Recls::Ximpl::absolute_path(''))

		assert_equal('', Recls::Ximpl::absolute_path('', cwd))

	end

	def test_rooted_paths

		assert_equal('/', Recls::Ximpl::absolute_path('/'))
		assert_equal('/abc', Recls::Ximpl::absolute_path('/abc'))
		assert_equal('/abc/def', Recls::Ximpl::absolute_path('/abc/def'))
		assert_equal('/abc/def/', Recls::Ximpl::absolute_path('/abc/def/'))
		assert_equal('/abc/def/file.ext', Recls::Ximpl::absolute_path('/abc/def/file.ext'))

		assert_equal('/', Recls::Ximpl::absolute_path('/', cwd))
		assert_equal('/abc', Recls::Ximpl::absolute_path('/abc', cwd))
		assert_equal('/abc/def', Recls::Ximpl::absolute_path('/abc/def', cwd))
		assert_equal('/abc/def/', Recls::Ximpl::absolute_path('/abc/def/', cwd))
		assert_equal('/abc/def/file.ext', Recls::Ximpl::absolute_path('/abc/def/file.ext', cwd))

	end

	def test_single_dot

		assert_equal("#{cwd}", Recls::Ximpl::absolute_path('.'))
		assert_equal("#{cwd}/", Recls::Ximpl::absolute_path('./'))

		assert_equal("/dir.1/dir.2", Recls::Ximpl::absolute_path('.', "/dir.1/dir.2"))
		assert_equal("/dir.1/dir.2/", Recls::Ximpl::absolute_path('./', "/dir.1/dir.2"))

		assert_equal("/dir.1/dir.2", Recls::Ximpl::absolute_path('.', "/dir.1/dir.2/"))
		assert_equal("/dir.1/dir.2/", Recls::Ximpl::absolute_path('./', "/dir.1/dir.2/"))

	end

	def test_double_dots

		assert_equal("/dir.13", Recls::Ximpl::absolute_path('..', "/dir.13/dir.2"))
		assert_equal("/dir.13/", Recls::Ximpl::absolute_path('../', "/dir.13/dir.2"))

		assert_equal("/dir.1/", Recls::Ximpl::absolute_path('../', "/dir.1/dir.2"))

	end
end

class Test_Recls_Ximpl_derive_relative_path < Test::Unit::TestCase

	attr_reader :cwd

	def setup

		@cwd = Dir.getwd

	end

	def test_absolute_proper_subset

		assert_equal('abc', Recls::Ximpl::derive_relative_path('/dir1/dir2', '/dir1/dir2/abc'))
		assert_equal('abc', Recls::Ximpl::derive_relative_path('/dir1/dir2/', '/dir1/dir2/abc'))
		assert_equal('abc/', Recls::Ximpl::derive_relative_path('/dir1/dir2', '/dir1/dir2/abc/'))
		assert_equal('abc/', Recls::Ximpl::derive_relative_path('/dir1/dir2/', '/dir1/dir2/abc/'))

		assert_equal('abc', Recls::Ximpl::derive_relative_path('dir1/dir2', 'dir1/dir2/abc'))
		assert_equal('abc', Recls::Ximpl::derive_relative_path('dir1/dir2/', 'dir1/dir2/abc'))
		assert_equal('abc/', Recls::Ximpl::derive_relative_path('dir1/dir2', 'dir1/dir2/abc/'))
		assert_equal('abc/', Recls::Ximpl::derive_relative_path('dir1/dir2/', 'dir1/dir2/abc/'))

#		assert_equal('/dir/dir2/abc', Recls::Ximpl::derive_relative_path('/dir1/dir2/abc', 'dir1/dir2'))
#		assert_equal('/dir/dir2/abc', Recls::Ximpl::derive_relative_path('/dir1/dir2/abc', 'dir1/dir2/'))

	end

	def test_absolute_proper_subset_2

		assert_equal('c++', Recls::Ximpl::derive_relative_path('/dir1/dir2', '/dir1/dir2/c++'))
		assert_equal('c++', Recls::Ximpl::derive_relative_path('/dir1/dir2/', '/dir1/dir2/c++'))

		assert_equal('c++', Recls::Ximpl::derive_relative_path('dir1/dir2', 'dir1/dir2/c++'))
		assert_equal('c++', Recls::Ximpl::derive_relative_path('dir1/dir2/', 'dir1/dir2/c++'))

	end

	def test_absolute_same_1

		assert_equal('.', Recls::Ximpl::derive_relative_path('/dir1/dir2/abc', '/dir1/dir2/abc'))
		assert_equal('./', Recls::Ximpl::derive_relative_path('/dir1/dir2/abc', '/dir1/dir2/abc/'))
		assert_equal('.', Recls::Ximpl::derive_relative_path('/dir1/dir2/abc/', '/dir1/dir2/abc'))
		assert_equal('./', Recls::Ximpl::derive_relative_path('/dir1/dir2/abc/', '/dir1/dir2/abc/'))

		assert_equal('.', Recls::Ximpl::derive_relative_path('dir1/dir2/abc', 'dir1/dir2/abc'))
		assert_equal('./', Recls::Ximpl::derive_relative_path('dir1/dir2/abc', 'dir1/dir2/abc/'))
		assert_equal('.', Recls::Ximpl::derive_relative_path('dir1/dir2/abc/', 'dir1/dir2/abc'))
		assert_equal('./', Recls::Ximpl::derive_relative_path('dir1/dir2/abc/', 'dir1/dir2/abc/'))

	end

	def test_absolute_same_2

		assert_equal('.', Recls::Ximpl::derive_relative_path('/dir1', '/dir1'))
		assert_equal('.', Recls::Ximpl::derive_relative_path('/dir1/', '/dir1'))

	end

	def test_absolute_same_3

		assert_equal('./', Recls::Ximpl::derive_relative_path('/', '/'))

	end

	def test_different_sub_trees_1

		assert_equal('../abc', Recls::Ximpl::derive_relative_path('/dir1/dir2/ref', '/dir1/dir2/abc'))
		assert_equal('../abc/', Recls::Ximpl::derive_relative_path('/dir1/dir2/ref', '/dir1/dir2/abc/'))
		assert_equal('../abc', Recls::Ximpl::derive_relative_path('/dir1/dir2/ref/', '/dir1/dir2/abc'))
		assert_equal('../abc/', Recls::Ximpl::derive_relative_path('/dir1/dir2/ref/', '/dir1/dir2/abc/'))

	end

	def test_different_sub_trees_2

		assert_equal('../abc', Recls::Ximpl::derive_relative_path('/ref', '/abc'))
		assert_equal('../abc/', Recls::Ximpl::derive_relative_path('/ref', '/abc/'))
		assert_equal('../abc', Recls::Ximpl::derive_relative_path('/ref/', '/abc'))
		assert_equal('../abc/', Recls::Ximpl::derive_relative_path('/ref/', '/abc/'))

	end

	def test_different_sub_trees_3

		assert_equal('../../dir3/abc', Recls::Ximpl::derive_relative_path('/dir1/dir2/ref', '/dir1/dir3/abc'))
		assert_equal('../../dir3/abc/', Recls::Ximpl::derive_relative_path('/dir1/dir2/ref', '/dir1/dir3/abc/'))
		assert_equal('../../dir3/abc', Recls::Ximpl::derive_relative_path('/dir1/dir2/ref/', '/dir1/dir3/abc'))
		assert_equal('../../dir3/abc/', Recls::Ximpl::derive_relative_path('/dir1/dir2/ref/', '/dir1/dir3/abc/'))

	end

	def test_different_sub_trees_4

		assert_equal('..', Recls::Ximpl::derive_relative_path('/dir1/dir2/ref', '/dir1/dir2'))
		assert_equal('..', Recls::Ximpl::derive_relative_path('/dir1/dir2/ref/', '/dir1/dir2'))
		assert_equal('..', Recls::Ximpl::derive_relative_path('/dir1/dir2/ref', '/dir1/dir2/'))
		assert_equal('..', Recls::Ximpl::derive_relative_path('/dir1/dir2/ref/', '/dir1/dir2/'))

	end

	def test_different_sub_trees_5

		assert_equal('../..', Recls::Ximpl::derive_relative_path('/dir1/dir2/dir3/dir4', '/dir1/dir2'))
		assert_equal('../..', Recls::Ximpl::derive_relative_path('/dir1/dir2/dir3/dir4/', '/dir1/dir2'))
		assert_equal('../..', Recls::Ximpl::derive_relative_path('/dir1/dir2/dir3/dir4', '/dir1/dir2/'))
		assert_equal('../..', Recls::Ximpl::derive_relative_path('/dir1/dir2/dir3/dir4/', '/dir1/dir2/'))

	end

	def test_embedded_dots_1

		assert_equal('.', Recls::Ximpl::derive_relative_path('./dir1/dir2', 'dir1/dir2'))
		assert_equal('./', Recls::Ximpl::derive_relative_path('./dir1/dir2', 'dir1/dir2/'))
		assert_equal('.', Recls::Ximpl::derive_relative_path('./dir1/dir2/', 'dir1/dir2'))
		assert_equal('./', Recls::Ximpl::derive_relative_path('./dir1/dir2/', 'dir1/dir2/'))

		assert_equal('.', Recls::Ximpl::derive_relative_path('./dir1/dir2', './dir1/dir2'))
		assert_equal('./', Recls::Ximpl::derive_relative_path('./dir1/dir2', './dir1/dir2/'))
		assert_equal('.', Recls::Ximpl::derive_relative_path('./dir1/dir2/', './dir1/dir2'))
		assert_equal('./', Recls::Ximpl::derive_relative_path('./dir1/dir2/', './dir1/dir2/'))

	end

	def test_embedded_dots_2

		assert_equal('.', Recls::Ximpl::derive_relative_path('dir1/./dir2', 'dir1/dir2'))
		assert_equal('./', Recls::Ximpl::derive_relative_path('dir1/./dir2', 'dir1/dir2/'))
		assert_equal('.', Recls::Ximpl::derive_relative_path('dir1/./dir2/', 'dir1/dir2'))
		assert_equal('./', Recls::Ximpl::derive_relative_path('dir1/./dir2/', 'dir1/dir2/'))
		assert_equal('.', Recls::Ximpl::derive_relative_path('dir1/./dir2', './dir1/dir2'))
		assert_equal('./', Recls::Ximpl::derive_relative_path('dir1/./dir2', './dir1/dir2/'))
		assert_equal('.', Recls::Ximpl::derive_relative_path('dir1/./dir2/', './dir1/dir2'))
		assert_equal('./', Recls::Ximpl::derive_relative_path('dir1/./dir2/', './dir1/dir2/'))

	end

	def test_embedded_dots_3

		assert_equal('.', Recls::Ximpl::derive_relative_path('dir1/dir2/.', 'dir1/dir2'))
		assert_equal('./', Recls::Ximpl::derive_relative_path('dir1/dir2/.', 'dir1/dir2/'))
		assert_equal('.', Recls::Ximpl::derive_relative_path('dir1/dir2/./', 'dir1/dir2'))
		assert_equal('./', Recls::Ximpl::derive_relative_path('dir1/dir2/./', 'dir1/dir2/'))
		assert_equal('.', Recls::Ximpl::derive_relative_path('dir1/dir2/.', './dir1/dir2'))
		assert_equal('./', Recls::Ximpl::derive_relative_path('dir1/dir2/.', './dir1/dir2/'))
		assert_equal('.', Recls::Ximpl::derive_relative_path('dir1/dir2/./', './dir1/dir2'))
		assert_equal('./', Recls::Ximpl::derive_relative_path('dir1/dir2/./', './dir1/dir2/'))

	end

	def test_embedded_dots_4

		assert_equal('.', Recls::Ximpl::derive_relative_path('dir1/./dir2/.', 'dir1/dir2'))
		assert_equal('./', Recls::Ximpl::derive_relative_path('dir1/./dir2/.', 'dir1/dir2/'))
		assert_equal('.', Recls::Ximpl::derive_relative_path('dir1/./dir2/./', 'dir1/dir2'))
		assert_equal('./', Recls::Ximpl::derive_relative_path('dir1/./dir2/./', 'dir1/dir2/'))
		assert_equal('.', Recls::Ximpl::derive_relative_path('dir1/./dir2/.', './dir1/dir2'))
		assert_equal('./', Recls::Ximpl::derive_relative_path('dir1/./dir2/.', './dir1/dir2/'))
		assert_equal('.', Recls::Ximpl::derive_relative_path('dir1/./dir2/./', './dir1/dir2'))
		assert_equal('./', Recls::Ximpl::derive_relative_path('dir1/./dir2/./', './dir1/dir2/'))

	end

	def test_embedded_dots_5

		assert_equal('.', Recls::Ximpl::derive_relative_path('./dir1/./dir2/.', 'dir1/dir2'))
		assert_equal('./', Recls::Ximpl::derive_relative_path('./dir1/./dir2/.', 'dir1/dir2/'))
		assert_equal('.', Recls::Ximpl::derive_relative_path('./dir1/./dir2/./', 'dir1/dir2'))
		assert_equal('./', Recls::Ximpl::derive_relative_path('./dir1/./dir2/./', 'dir1/dir2/'))
		assert_equal('.', Recls::Ximpl::derive_relative_path('./dir1/./dir2/.', './dir1/dir2'))
		assert_equal('./', Recls::Ximpl::derive_relative_path('./dir1/./dir2/.', './dir1/dir2/'))
		assert_equal('.', Recls::Ximpl::derive_relative_path('./dir1/./dir2/./', './dir1/dir2'))
		assert_equal('./', Recls::Ximpl::derive_relative_path('./dir1/./dir2/./', './dir1/dir2/'))

	end

	def test_embedded_dots_6

		assert_equal('.', Recls::Ximpl::derive_relative_path('./dir1/././././dir2/.', 'dir1/dir2'))
		assert_equal('./', Recls::Ximpl::derive_relative_path('./dir1/././././dir2/.', 'dir1/dir2/'))
		assert_equal('.', Recls::Ximpl::derive_relative_path('./dir1/././././dir2/./', 'dir1/dir2'))
		assert_equal('./', Recls::Ximpl::derive_relative_path('./dir1/././././dir2/./', 'dir1/dir2/'))
		assert_equal('.', Recls::Ximpl::derive_relative_path('./dir1/././././dir2/.', './dir1/dir2'))
		assert_equal('./', Recls::Ximpl::derive_relative_path('./dir1/././././dir2/.', './dir1/dir2/'))
		assert_equal('.', Recls::Ximpl::derive_relative_path('./dir1/././././dir2/./', './dir1/dir2'))
		assert_equal('./', Recls::Ximpl::derive_relative_path('./dir1/././././dir2/./', './dir1/dir2/'))

	end

	def test_embedded_dots_7

		assert_equal('.', Recls::Ximpl::derive_relative_path('./dir1/././././dir2/.', 'dir1/././dir2'))
		assert_equal('./', Recls::Ximpl::derive_relative_path('./dir1/././././dir2/.', 'dir1/././dir2/'))
		assert_equal('.', Recls::Ximpl::derive_relative_path('./dir1/././././dir2/./', 'dir1/././dir2'))
		assert_equal('./', Recls::Ximpl::derive_relative_path('./dir1/././././dir2/./', 'dir1/././dir2/'))
		assert_equal('.', Recls::Ximpl::derive_relative_path('./dir1/././././dir2/.', './dir1/././dir2'))
		assert_equal('./', Recls::Ximpl::derive_relative_path('./dir1/././././dir2/.', './dir1/././dir2/'))
		assert_equal('.', Recls::Ximpl::derive_relative_path('./dir1/././././dir2/./', './dir1/././dir2'))
		assert_equal('./', Recls::Ximpl::derive_relative_path('./dir1/././././dir2/./', './dir1/././dir2/'))

	end
end


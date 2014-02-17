
require 'recls'

require 'test/unit'

class Test_Recls_Ximpl_Util_get_windows_root < Test::Unit::TestCase

	def test_get_windows_root

		wr, rem = Recls::Ximpl::Util.get_windows_root('.')
		assert_nil(wr)
		assert_not_nil(rem)
		assert_equal('.', rem)

		wr, rem = Recls::Ximpl::Util.get_windows_root('..')
		assert_nil(wr)
		assert_not_nil(rem)
		assert_equal('..', rem)

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

class Test_Recls_Ximpl_module_functions < Test::Unit::TestCase

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


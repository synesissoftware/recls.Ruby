# ######################################################################### #
# File:        recls/ximpl/util.rb
#
# Purpose:     Internal implementation constructs for the recls library.
#
# Created:     24th July 2012
# Updated:     13th October 2014
#
# Author:      Matthew Wilson
#
# Copyright:   <<TBD>>
#
# ######################################################################### #


require File.join(File.dirname(__FILE__), 'os')
require File.join(File.dirname(__FILE__), '..', 'flags')

module Recls

	module Ximpl

		module Util

			def Util.is_path_name_separator(c)

				return true if ?/ == c

				if Recls::Ximpl::OS::OS_IS_WINDOWS
					return true if ?\\ == c
				end

				return false

			end # def Util.is_path_name_separator

			# Indicates whether a trailing slash is on the given path
			#
			# dependencies: none
			def Util.has_trailing_slash(p)

				return p if p.nil? or p.empty?

				return Util.is_path_name_separator(p[-1])

			end # Util.has_trailing_slash

			# returns the trailing slash, or nil if none present
			#
			# dependencies: none
			def Util.get_trailing_slash(p, args = {})

				return nil if p.nil?
				return nil if p.empty?

				return Util.is_path_name_separator(p[-1]) ? p[-1] : nil

			end # Util.get_trailing_slash

			# appends trailing slash to a path if not already
			# present
			#
			# dependencies: none
			def Util.append_trailing_slash(p, slash = nil)

				return p if not p or p.empty?

				return p if Util.is_path_name_separator(p[-1])

				slash = '/' if not slash

				"#{p}#{slash}"

			end # def Util.append_trailing_slash(p)

			# trims trailing slash from a path, unless it is the
			# root
			#
			# dependencies: none
			def Util.trim_trailing_slash(p)

				return p if not p or p.empty?

				p = p[0 ... -1] if Util.is_path_name_separator(p[-1])

				return p

			end # def Util.trim_trailing_slash(p)

			# From path p, returns a tuple containing either:
			#
			#  [ nil, p ] if p does not contain a Windows root, or
			#
			#  [ wroot, remainder ] if p does contain a Windows root, or
			#
			#  [ nil, nil ] if p is nil
			#
			# dependencies: none
			def Util.get_windows_root(p)

				return [ nil, nil ] if not p

				if Recls::Ximpl::OS::OS_IS_WINDOWS

					# Windows local drive (e.g. 'H:')
					#
					# NOTE: this works for both rooted and unrooted paths
					if p =~ /^([a-zA-Z]:)/
						return [ $1, $' ]
					end

					# UNC network drive
					#
					# NOTE: there are several permutations ...
					if p =~ /^(\\\\[^\\\/:*?<>|]+\\[^\\\/:*?<>|]+)([\\\/].*)$/
						# \\server\share{\{... rest of path}}
						return [ $1, $2 ]
					end
					if p =~ /^(\\\\[^\\\/:*?<>|]+\\[^\\\/:*?<>|]+)$/
						# \\server\share
						return [ $1, nil ]
					end
					if p =~ /^(\\\\[^\\\/:*?<>|]+\\)$/
						# \\server\
						return [ $1, nil ]
					end
					if p =~ /^(\\\\[^\\\/:*?<>|]+)$/
						# \\server
						return [ $1, nil ]
					end
				end

				return [ nil, p ]

			end # def Util.get_windows_root

			# obtains the parts from a path, including any Windows root and
			# the file basename
			def Util.path_parts(path)

				return nil if path.nil?
				return [] if path.empty?

				parts = []

				wr, rem =  Util.get_windows_root(path)

				parts << wr if wr

				until rem.empty?
					if rem =~ /^([^\\\/]*[\\\/])/
						parts << $1
						rem = $'
					else
						parts << rem
						rem = ''
					end
				end

				parts

			end # Ximpl.directory_parts_from_directory

			# Returns a tuple consisting of the following
			# elements (or nil, for any element that is not)
			# present
			#
			# f1. Windows root, or nil
			# f2. directory, or nil
			# f3. basename, or nil
			# f4. basename-minus-extension, or nil
			# f5. extension, or nil
			# f6. array of directory path parts, which may be empty (not nil)
			# f7. array of all path parts, which may be empty (not nil)
			#
			# dependencies: Util.path_parts, Util.get_windows_root
			def Util.split_path(p)

				f1_windows_root, remainder = Util.get_windows_root p
				f1_windows_root = nil if not f1_windows_root or f1_windows_root.empty?
				remainder = nil if not remainder or remainder.empty?

				if not remainder or remainder.empty?
					f2_directory = nil
					f3_basename = nil
					f4_nameonly = nil
					f5_extension = nil
				else
					if remainder =~ /^(.*[\\\/])([^\\\/]*)$/
						f2_directory = $1
						f3_basename = $2
					else
						f2_directory = nil
						f3_basename = remainder
						f4_nameonly = nil
						f5_extension = nil
					end

					f2_directory = nil if not f2_directory or f2_directory.empty?
					f3_basename = nil if not f3_basename or f3_basename.empty?

					if f3_basename
						# special case: treat '.' and '..' as file-name only
						if '.' == f3_basename or '..' == f3_basename
							f4_nameonly = f3_basename
							f5_extension = nil
						elsif f3_basename =~ /^(.*)(\.[^.]*)$/
							f4_nameonly = $1
							f5_extension = $2
						else
							f4_nameonly = f3_basename
							f5_extension = nil
						end
					else
						f4_nameonly = nil
						f5_extension = nil
					end
				end

				f4_nameonly = nil if not f4_nameonly or f4_nameonly.empty?
				f5_extension = nil if not f5_extension or f5_extension.empty?
				f6_directory_parts = Util.path_parts(f2_directory)
				f7_path_parts = Util.path_parts(p)

				return [ f1_windows_root, f2_directory, f3_basename, f4_nameonly, f5_extension, f6_directory_parts, f7_path_parts ]

			end # def split_path(p)

			# Returns a tuple consisting of:
			#
			# f1. The canonicalised array of parts
			# f2. A boolean indicating whether to 'consume' the basename
			#
			# dependencies: OS.is_root_dir_, OS.get_number_of_dots_dir_,
			def Util.canonicalise_parts(parts, basename = nil)

				newParts = []

				trailing_slash = parts.empty? ? nil : Util.get_trailing_slash(parts[-1])

				lastSingleDots = nil

				path_is_rooted = nil

				index = -1
				parts.each do |part|

					index += 1

					next if not part
					next if part.empty?

					if path_is_rooted.nil?
						path_is_rooted = Util.is_path_name_separator(part[0])
					end

					if ?. == part[0]
						if Util.is_path_name_separator(part[1])
							# single dots, so ...

							# ... remember the last instance, and ...
							lastSingleDots = part

							# ... skip to leave this out of the result
							next
						elsif ?. == part[1]
							if Util.is_path_name_separator(part[2])
								# double dots, so ...
								# ... skip this and pop prior from the new list iff:
								#
								# 1. there is a prior elements in the new list (size > 1); AND
								# 2. the last element in the new list is not the root directory; AND
								# 3. the last element in the list is not a dots directory
								if not newParts.empty? # 1.
									priorPart = newParts[-1]
									if 1 == newParts.size and OS.is_root_dir_(priorPart)
										# 2.
										next
									else
										dirtype = OS.get_number_of_dots_dir_(priorPart)
										if 0 == dirtype # 3.
											if newParts.pop
												next
											end
										end
									end
								end
							else
								# it's a ..X part
							end
						else
							# it's a .X part
						end
					else
						# it's a non-dots part
					end

					newParts << part
				end

				consume_basename = false

				if basename
					if ?. == basename[0]
						if 1 == basename.size
							# single dots
							if newParts.empty?
								lastSingleDots = false
							else
								consume_basename = true
							end
						elsif ?. == basename[1] and 2 == basename.size
							# double dots, so ...
							#
							# ... pop unless we already have some outstanding double dots
							if newParts.empty?
								newParts << '..'
								consume_basename = true
							elsif 1 == newParts.size && 1 == newParts[0].size && Util.is_path_name_separator(newParts[0][0])
								consume_basename = true
							else
								if 2 != OS.get_number_of_dots_dir_(newParts[-1])
									newParts.pop
									consume_basename = true
								end
							end
						end
					end
				end

				# push lastSingleDots (which may contain a trailing slash) if
				# exists and newParts is empty
				newParts << lastSingleDots if lastSingleDots and newParts.empty?

				if not newParts.empty?
					if 2 == OS.get_number_of_dots_dir_(newParts[-1])
						# the last element is the double-dots directory, but
						# need to determine whether to ensure/remote a
						# trailing slash
						if basename and not basename.empty?
							if not consume_basename
								# leave as is
							else
								# 
								newParts[-1] = '..'
							end
						end
					end
				else
					# handle case where all (double)-dots have eliminated
					# all regular directories
					if not basename or basename.empty? or consume_basename
						newParts << '.'
					end
				end

				[ newParts.join(''), consume_basename ]

			end # def canonicalise_parts(parts, basename)

		end # module Util

		# Canonicalises a path
		#
		# Note: contains a trailing slash if, in the context of the given
		# path, the last element of the canonicalised path is a directory
		# unequivocally
		def Ximpl.canonicalise_path(path)

			return nil if not path
			return '' if path.empty?

			f1_windows_root, f2_directory, f3_basename, dummy1, dummy2, directory_parts, dummy3 = Util.split_path(path)

			if not f2_directory
				canonicalised_directory = nil
			else
				canonicalised_directory, consume_basename = Util.canonicalise_parts(directory_parts, f3_basename)
				f3_basename = nil if consume_basename
			end

			return "#{f1_windows_root}#{canonicalised_directory}#{f3_basename}"

		end # Ximpl.canonicalise_path(path)

		# determines the absolute path of a given path
		def Ximpl.absolute_path(path, refdir = nil)

			return nil if not path
			return '' if path.empty?

			f1_windows_root, f2_directory, f3_basename, dummy1, dummy2, dummy3, dummy4 = Util.split_path(path)

			if f2_directory =~ /^[\\\/]/
				return path
			end

			cwd = refdir ? refdir : Dir.getwd

			trailing_slash = Util.get_trailing_slash(path)

			if '.' == path
				return Util.trim_trailing_slash cwd
			elsif 2 == path.size and trailing_slash
				return Util.append_trailing_slash(cwd, path[1..1])
			end

			cwd = Util.append_trailing_slash(cwd)

			path = "#{cwd}#{path}"

			path = canonicalise_path path

			if trailing_slash
				path = Util.append_trailing_slash path, trailing_slash
			else
				path = Util.trim_trailing_slash path
			end

			return path

			#File::absolute_path path

		end # def Ximpl.absolute_path

		# obtains the basename of a path, e.g.
		# the basename of
		#  abc/def/ghi.jkl
		# or (on Windows)
		#  C:\abc\def\ghi.jkl
		# is
		#  ghi.jkl
		#
		def Ximpl.basename(path)

			return nil if not path

			# NOTE: we don't implement in terms of split_path
			# because all but the UNC case work with just
			# detecting the last (back)slash

			if Recls::Ximpl::OS::OS_IS_WINDOWS
				wr, rem = Util.get_windows_root(path)

				if not rem
					return ''
				else
					path = rem
				end
			end

			if not path.is_a? String
				path = path.to_s
			end

			if path =~ /^.*[\/\\](.*)/
				$1
			else
				path
			end

		end # Ximpl.basename

		# obtains the file extension of a basename, e.g.
		# the file_ext of
		#  ghi.jkl
		# is
		#  .jkl
		def Ximpl.file_ext(path)

			return nil if not path

			use_split_path = false

			if Recls::Ximpl::OS::OS_IS_WINDOWS
				if path.include? ?\\
					use_split_path = true
				end
			end

			if path.include? ?/
				use_split_path = true
			end

			if use_split_path
				ext = Util.split_path(path)[4]
			else
				if path =~ /^.*(\.[^.]*)$/
					ext = $1
				else
					ext = nil
				end
			end

			return ext ? ext : ''

		end # Ximpl.file_ext

		# obtains the directory from the directory path
		#
		def Ximpl.directory_from_directory_path(directory_path)

			wr, rem =  Util.get_windows_root(directory_path)

			rem

		end # Ximpl.directory_from_directory_path

		# obtains the directory parts from a directory
		def Ximpl.directory_parts_from_directory(directory)

			return nil if not directory

			directory_parts = []

			until directory.empty?
				if directory =~ /^([^\\\/]*[\\\/])/
					directory_parts << $1
					directory = $'
				else
					directory_parts << directory
					directory = ''
				end
			end

			directory_parts

		end # Ximpl.directory_parts_from_directory

		# obtains the relative path of a given path and
		# a reference directory
		def Ximpl.derive_relative_path(origin, path)

			return nil if path.nil?
			return nil if path.empty?
			return path if origin.nil?
			return path if origin.empty?

			path			=	Ximpl.canonicalise_path path
			origin			=	Ximpl.canonicalise_path origin

			path_splits		=	Util.split_path(path)
			origin_splits	=	Util.split_path(origin)

			# if different windows root, then cannot provide relative
			if path_splits[0] and origin_splits[0]
				return path if path_splits[0] != ref_splits[0]
			end

			trailing_slash	=	Util.get_trailing_slash(path)

			path_parts		=	path_splits[6]
			origin_parts	=	origin_splits[6]

			while true

				break if path_parts.empty?
				break if origin_parts.empty?

				path_part	=	path_parts[0]
				origin_part	=	origin_parts[0]

				if 1 == path_parts.size || 1 == origin_parts.size
					path_part	=	Util.append_trailing_slash(path_part)
					origin_part	=	Util.append_trailing_slash(origin_part)
				end

				if path_part == origin_part
					path_parts.shift
					origin_parts.shift
				else
					break
				end
			end

			return ".#{trailing_slash}" if path_parts.empty? and origin_parts.empty?

			# at this point, all reference parts should be converted into '..'

			return origin_parts.map { |rp| '..' }.join('/') if path_parts.empty?

			return '../' * origin_parts.size + path_parts.join('')

		end # def Ximpl.derive_relative_path

		# Elicits the contents of the given directory, or, if the flag
		# STOP_ON_ACCESS_FAILURE is specified throws an exception if the
		# directory does not exist
		#
		# Some known conditions:
		#
		# * (Mac OSX) /dev/fd/<N> - some of these stat() as directories but
		#    Dir::new fails with ENOTDIR
		#
		def Ximpl.dir_entries_maybe(dir, flags)

			begin

				Dir.new(dir).to_a

			rescue SystemCallError => x

				# TODO this should be filtered up and/or logged

				if(0 != (STOP_ON_ACCESS_FAILURE & flags))
					raise
				end

				return []

			rescue Exception => x

			end

		end # Ximpl.dir_entries_maybe

	end # module Ximpl

end # module Recls

# ############################## end of file ############################# #


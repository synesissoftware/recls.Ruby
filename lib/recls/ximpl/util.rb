# ######################################################################### #
# File:        recls/ximpl/util.rb
#
# Purpose:     Internal implementation constructs for the recls library.
#
# Created:     24th July 2012
# Updated:     16th February 2014
#
# Author:      Matthew Wilson
#
# Copyright:   <<TBD>>
#
# ######################################################################### #

require File.dirname(__FILE__) + '/os'

module Recls

	module Ximpl

		module Util

			# From path p, returns a tuple containing either:
			#
			#  [ nil, p ] if p does not contain a Windows root, or
			#
			#  [ wroot, remainder ] if p does contain a Windows root, or
			#
			#  [ nil, nil ] if p is nil
			#
			def Util.get_windows_root(p)

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

			# Returns a tuple consisting of the following
			# elements (or nil, for any element that is not)
			# present
			#
			# f1. Windows root, or nil
			# f2. Directory, or nil
			# f3. basename, or nil
			# f4. basename-minus-extension, or nil
			# f5. extension, or nil
			def Util.split_path(p)

				f1_windows_root, remainder = get_windows_root p
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
						if f3_basename =~ /^(.*)(\.[^.]*)$/
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

				return [ f1_windows_root, f2_directory, f3_basename, f4_nameonly, f5_extension ]

			end # def split_path(p)

			# Returns a tuple consisting of:
			#
			# f1. The canonicalised array of parts
			# f2. A boolean indicating whether to 'consume' the basename
			def Util.canonicalise_parts(parts, basename = nil)

				newParts = []

				lastSingleDots = nil
				doubleDotsCount = 0

				index = 0
				parts.each do |part|

					next if not part
					next if part.empty?

					if ?. == part[0]
						if ?/ == part[1] || (Recls::Ximpl::OS::OS_IS_WINDOWS && ?\\ == part[1])
							# single dots, so ...

							# ... remember the last instance, and ...
							lastSingleDots = part

							# ... skip to leave this out of the result
							next
						elsif ?. == part[1]
							if ?/ == part[2] || (Recls::Ximpl::OS::OS_IS_WINDOWS && ?\\ == part[2])
								# double dots, so ...

								if 0 != doubleDotsCount
									doubleDotsCount += 1
								else
									if newParts.pop
										next
									else
										doubleDotsCount += 1
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
							# ... pop unless we already have some outstanding doubleDots
							if newParts.empty?
								newParts << '..'
								consume_basename = true
							else
								newParts.pop if 0 == doubleDotsCount
							end
						end
					end
				end

				newParts << '.' if lastSingleDots and newParts.empty?

				if not newParts.empty?
					if newParts[-1] == '../'
						if not basename or basename.empty? or consume_basename
							newParts[-1] = '..'
						end
					end
				end

				[ newParts, consume_basename ]

			end # def canonicalise_parts(parts, basename)

		end # module Util

		def Ximpl.canonicalise_path(path)

			return nil if not path
			return '' if path.empty?

			f1_windows_root, f2_directory, f3_basename, dummy1, dummy2 = Util.split_path(path)

			if not f2_directory
				canonicalised_directory = nil
			else
				parts = directory_parts_from_directory f2_directory
				canonicalised_directory, consume_basename = Util.canonicalise_parts(parts, f3_basename)
				f3_basename = nil if consume_basename
			end

			return "#{f1_windows_root}#{canonicalised_directory}#{f3_basename}"

		end # Ximpl.canonicalise_path(path)

		def Ximpl.absolute_path(path)

			return nil if not path
			return '' if path.empty?

			f1_windows_root, f2_directory, f3_basename, dummy1, dummy2 = Util.split_path(path)


			if f2_directory =~ /^[\\\/]/

				return path

			end

			File::absolute_path path

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

			return nil if not directory_path

			if directory_path =~ /^[a-zA-Z]:([\\\/].*)/
				directory = $1
			elsif directory_path =~ /^\\\\[^\\\/:*?<>|]+\\[^\\\/:*?<>|]+/
				directory = $'
			else
				directory = directory_path
			end

			directory

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

		# obtains the search_relative_path from a path and
		# a search_directory
		def Ximpl.search_relative_path(path, search_directory)

			if search_directory and not search_directory.empty?

				if path =~ /^#{search_directory}[\\\/]/
					$'
				else
					path
				end
			else
				path
			end

		end # Ximpl.search_relative_path

	end # module Ximpl

end # module Recls


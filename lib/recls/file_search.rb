# ######################################################################### #
# File:         recls/file_search.rb
#
# Purpose:      Defines the Recls::FileSearch class for the recls.Ruby library.
#
# Created:      24th July 2012
# Updated:      21st March 2019
#
# Author:       Matthew Wilson
#
# Copyright (c) 2012-2019, Matthew Wilson and Synesis Software
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:
#
# * Redistributions of source code must retain the above copyright notice,
#   this list of conditions and the following disclaimer.
#
# * Redistributions in binary form must reproduce the above copyright notice,
#   this list of conditions and the following disclaimer in the documentation
#   and/or other materials provided with the distribution.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
# ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
# LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
# CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
# SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
# INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
# CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
# ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
# POSSIBILITY OF SUCH DAMAGE.
#
# ######################################################################### #


require 'recls/entry'
require 'recls/flags'
require 'recls/ximpl/os'

module Recls

	class FileSearch

		include Enumerable

		# Initialises a +FileSearch+ instance, which acts as an +Enumerable+
		# of Recls::Entry
		#
		# === Signature
		#
		# * *Parameters:*
		#   - +search_root+:: (String, Recls::Entry) The root directory of
		#    the search. May be +nil+, in which case the current directory
		#    is assumed
		#   - +patterns+:: (String, Array) The pattern(s) for which to
		#    search. May be +nil+, in which case +Recls::WILDCARDS_ALL+ is
		#    assumed
		#   - +options+:: (Hash, Integer) Combination of flags (with
		#    behaviour as described below for the +flags+ option), or an
		#    options hash
		#
		# * *Options:*
		#   - +flags+:: (Integer) Combination of flags - FILES,
		#    DIRECTORIES, RECURSIVE, etc. If the value modulo TYPEMASK is 0,
		#    then FILES is assumed
		#
		# === Return
		#  An instance of the class
		#
		def initialize(search_root, patterns, options={})

			# for backwards compatibility, we allow for options to
			# be a number

			flags	=	0

			case options
			when ::NilClass

				options	=	{ flags: 0 }
			when ::Integer

				flags	=	options
				options	=	{ flags: flags }
			when ::Hash

				flags	=	options[:flags] || 0
			else

				raise ArgumentError, "options parameter must a #{::Hash}, nil, or an integer specifying flags - an instance of #{options.class} given"
			end


			if not search_root

				search_root = '.'
			else

				search_root = search_root.to_s
			end
			search_root = '.' if search_root.empty?
			search_root = File.expand_path(search_root) if '~' == search_root[0]

			case	patterns
			when	NilClass

				patterns = []
			when	String

				patterns = patterns.split(/[|#{Recls::Ximpl::OS::PATH_SEPARATOR}]/)
			when	Array
			else

				patterns = patterns.to_a
			end

			patterns = [ Recls::WILDCARDS_ALL ] if patterns.empty?

			if(0 == (Recls::TYPEMASK & flags))

				flags |= Recls::FILES
			end

			# now de-dup the patterns, to avoid duplicates in search
			patterns		=	patterns.flatten
			patterns		=	patterns.uniq

			@search_root	=	search_root
			@patterns		=	patterns
			@flags			=	flags
		end

		attr_reader :search_root
		attr_reader :patterns
		attr_reader :flags

		def each(&blk)

			search_root = @search_root
			search_root = Recls::Ximpl::absolute_path search_root

			search_root = search_root.gsub(/\\/, '/') if Recls::Ximpl::OS::OS_IS_WINDOWS

			# set the (type part of the) flags to zero if we want
			# everything, to facilitate later optimisation

			flags = @flags

			if(Recls::Ximpl::OS::OS_IS_WINDOWS)

				mask = (Recls::FILES | Recls::DIRECTORIES)
			else

				mask = (Recls::FILES | Recls::DIRECTORIES | Recls::LINKS | Recls::DEVICES)
			end

			if(mask == (mask & flags))

				flags = flags & ~Recls::TYPEMASK
			end

			patterns = @patterns

			patterns = patterns.map do |pattern|

				pattern = pattern.gsub(/\./, '\\.')
				pattern = pattern.gsub(/\?/, '.')
				pattern = pattern.gsub(/\*/, '.*')
				pattern
			end

			search_dir	=	search_root
			search_root	=	Recls::Ximpl::Util.append_trailing_slash search_root

			FileSearch::search_directory_(search_root, search_dir, patterns, flags, &blk)
		end

		private
		def FileSearch::is_dots(name)

			case	name
			when	'.', '..'
				true
			else
				false
			end
		end

		def FileSearch::stat_or_nil_(path, flags)

			begin

				Recls::Ximpl::FileStat.stat path
			rescue Errno::ENOENT => x

				nil
			rescue SystemCallError => x

				# TODO this should be filtered up and/or logged

				if(0 != (STOP_ON_ACCESS_FAILURE & flags))

					raise
				end

				nil
			end
		end

		# searches all entries - files, directories, links, devices
		# - that match the given (patterns) in the given directory
		# (dir) according to the given (flags), invoking the given
		# block (blk). The search directory (search_root) is passed in
		# order to allow calculation of search_relative_path in the
		# entry.

		def FileSearch::search_directory_(search_root, dir, patterns, flags, &blk)

			# array of FileStat instances
			entries = []

			patterns.each do |pattern|

				Recls::Ximpl::dir_entries_maybe(dir, flags).each do |name|

					next if is_dots(name)

					if not name =~ /^#{pattern}$/

						next
					end

					entry_path = File::join(dir, name)

					fs = stat_or_nil_(entry_path, flags)

					entries << fs
				end
			end

			# array of FileStat instances
			subdirectories = []

			Recls::Ximpl::dir_entries_maybe(dir, flags).each do |subdir|

				next if is_dots(subdir)

				subdir_path = File::join(dir, subdir)

				fs = stat_or_nil_(subdir_path, flags)

				next if not fs

				next unless fs.directory?

				subdirectories << fs
			end


			# now filter the file-stat instances and send each
			# remaining to the block in Entry instance
			entries.each do |fs|

				next if not fs

				if(0 == (Recls::SHOW_HIDDEN & flags))

					if fs.hidden?

						next
					end
				end

				match	=	false

				match	||=	(0 != (Recls::FILES & flags) && fs.file?)
				match	||=	(0 != (Recls::DIRECTORIES & flags) && fs.directory?)
				match	||=	(0 != (Recls::DEVICES & flags) && fs.blockdev?)

				next unless match

				blk.call Recls::Entry.new(fs.path, fs, search_root, flags)
			end

			# sub-directories

			return unless (0 != (Recls::RECURSIVE & flags))

			subdirectories.each do |fs|

				if(0 == (Recls::SHOW_HIDDEN & flags))

					if fs.hidden?

						next
					end
				end

				if(0 == (Recls::SEARCH_THROUGH_LINKS & flags))

					if File.symlink? fs.path

						next
					end
				end

				FileSearch::search_directory_(search_root, fs.path, patterns, flags, &blk)
			end
		end
	end
end

# ############################## end of file ############################# #



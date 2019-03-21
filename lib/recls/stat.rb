# ######################################################################### #
# File:         recls/stat.rb
#
# Purpose:      Defines the Recls.stat() method for the recls.Ruby library.
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

module Recls

	# Performs a +stat()+ but returns +nil+ if an obtained entry is not a
	# directory
	def self.directory?(path, *args)

		fe = self.stat(path, *args)

		if fe

			return nil unless fe.directory?
		end

		fe
	end

	# Performs a +stat()+ but returns +nil+ if an obtained entry is not a
	# file
	def self.file?(path, *args)

		fe = self.stat(path, *args)

		if fe

			return nil unless fe.file?
		end

		fe
	end

	# USAGE:
	#
	#  - stat(path)
	#  - stat(path, flags)
	#  - stat(path, search_root)
	#  - stat(path, search_root, flags)
	#  - stat(path, flags, search_root)
	def self.stat(path, *args)

		flags		=	0
		search_root	=	nil
		message		=	nil

		path		=	File.expand_path(path) if path =~ /^~[\\\/]*/

		case	args.size
		when	0
			;
		when	1
			case	args[0]
			when	::Integer
				flags = args[0]
			when	::String
				search_root = args[0]
			else
				message = "argument '#{args[0]}' (#{args[0].class}) not valid"
			end
		when	2
			if false
			elsif ::Integer === args[0] && ::String === args[1]
				flags		=	args[0]
				search_root	=	args[1]
			elsif ::String === args[0] && ::Integer === args[1]
				search_root	=	args[0]
				flags		=	args[1]
			else
				message = "invalid combination of arguments"
			end
		else
			message = "too many arguments"
		end

		raise ArgumentError, "#{message}: Recls.stat() takes one (path), two (path+flags or path+search_root), or three (path+search_root+flags) arguments" if message

		begin

			Recls::Entry.new(path, Recls::Ximpl::FileStat.stat(path), search_root, flags)
		rescue Errno::ENOENT => x

			x = x # suppress warning

			if 0 != (flags & Recls::DETAILS_LATER)

				Recls::Entry.new(path, nil, search_root, flags)
			else

				nil
			end
		end
	end
end

# ############################## end of file ############################# #



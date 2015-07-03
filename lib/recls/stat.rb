# ######################################################################### #
# File:         recls/stat.rb
#
# Purpose:      Defines the Recls.stat() method for the recls.Ruby library.
#
# Created:      24th July 2012
# Updated:      3rd July 2015
#
# Author:       Matthew Wilson
#
# Copyright:    <<TBD>>
#
# ######################################################################### #


require 'recls/internal/common'
require 'recls/entry'
require 'recls/flags'

module Recls

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

			if 0 != (flags & Recls::DETAILS_LATER)

				Recls::Entry.new(path, nil, search_root, flags)
			else

				nil
			end
		end
	end 
end

# ############################## end of file ############################# #


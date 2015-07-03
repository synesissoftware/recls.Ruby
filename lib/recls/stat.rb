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
require 'recls/internal/version'
require 'recls/entry'
require 'recls/flags'

module Recls

	def self.stat(path, flags = 0)

		begin
			Recls::Entry.new(path, Recls::Ximpl::FileStat.stat(path), path, flags)
		rescue Errno::ENOENT => x

			if 0 != (flags & Recls::DETAILS_LATER)

				Recls::Entry.new(path, nil, path, flags)
			else

				nil
			end
		end
	end 
end

# ############################## end of file ############################# #


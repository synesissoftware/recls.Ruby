# ######################################################################### #
# File:         recls/stat.rb
#
# Purpose:      Defines the Recls.stat() method for the recls.ruby library.
#
# Created:      24th July 2012
# Updated:      10th June 2015
#
# Author:       Matthew Wilson
#
# Copyright:    <<TBD>>
#
# ######################################################################### #


require File.join(File.dirname(__FILE__), 'internal/common')
require File.join(File.dirname(__FILE__), 'internal/version')
require File.join(File.dirname(__FILE__), 'entry')
require File.join(File.dirname(__FILE__), 'flags')

module Recls

	def self.stat(path, flags = 0)

		begin
			Recls::Entry.new(path, Recls::Ximpl::FileStat.stat(path), path)
		rescue Errno::ENOENT => x

			if 0 != (flags & Recls::DETAILS_LATER)

				Recls::Entry.new(path, nil, path)
			else

				nil
			end
		end
	end 
end

# ############################## end of file ############################# #


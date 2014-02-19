# ######################################################################### #
# File:        recls/stat.rb
#
# Purpose:     Defines the Recls.stat() method for the recls.ruby library.
#
# Created:     24th July 2012
# Updated:     16th February 2014
#
# Author:      Matthew Wilson
#
# Copyright:   <<TBD>>
#
# ######################################################################### #


require File.dirname(__FILE__) + '/entry'
require File.dirname(__FILE__) + '/flags'

module Recls

	def Recls.stat(path, flags = 0)

		begin
			Recls::Entry::new(path, Recls::Ximpl::FileStat.stat(path), path)
		rescue Errno::ENOENT => x

			if 0 != (flags & Recls::DETAILS_LATER)
				Recls::Entry::new(path, nil, path)
			else
				nil
			end
		end

	end # def stat()

end # module Recls

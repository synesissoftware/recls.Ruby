# ######################################################################### #
# File:         recls/util.rb
#
# Purpose:      Utility module functions for recls library
#
# Created:      17th February 2014
# Updated:      12th October 2014
#
# Author:       Matthew Wilson
#
# Copyright:    <<TBD>>
#
# ######################################################################### #


require File.join(File.dirname(__FILE__), 'ximpl/common')
require File.join(File.dirname(__FILE__), 'version')
require File.join(File.dirname(__FILE__), 'ximpl/os')

module Recls

	# Canonicalises the given path, by removing dots ('.' and '..')
	# directories
	def Recls.canonicalise_path(path)

		return path

	end # def Recls.canonicalise_path

end # module Recls

# ############################## end of file ############################# #

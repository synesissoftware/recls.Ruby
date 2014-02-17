# ######################################################################### #
# File:         recls/util.rb
#
# Purpose:      Utility module functions for recls library
#
# Created:      17th February 2014
# Updated:      17th February 2014
#
# Author:       Matthew Wilson
#
# Copyright:    <<TBD>>
#
# ######################################################################### #


require File.dirname(__FILE__) + '/ximpl/os'

module Recls

	# Canonicalises the given path, by removing dots ('.' and '..')
	# directories
	def Recls.canonicalise_path(path)

		return path

	end # def Recls.canonicalise_path

end # module Recls


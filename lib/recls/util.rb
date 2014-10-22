# ######################################################################### #
# File:         recls/util.rb
#
# Purpose:      Utility module functions for recls library
#
# Created:      17th February 2014
# Updated:      22nd October 2014
#
# Author:       Matthew Wilson
#
# Copyright:    <<TBD>>
#
# ######################################################################### #


require File.join(File.dirname(__FILE__), 'internal/common')
require File.join(File.dirname(__FILE__), 'internal/version')
require File.join(File.dirname(__FILE__), 'ximpl/os')

module Recls

	# Canonicalises the given path, by removing dots ('.' and '..')
	# directories
	def Recls.canonicalise_path(path)

		return Recls::Ximpl::canonicalise_path path

	end # def Recls.canonicalise_path

	def Recls.derive_relative_path(origin, path)

		return Recls::Ximpl::derive_relative_path origin path

	end # def Recls.derive_relative_path

end # module Recls

# ############################## end of file ############################# #

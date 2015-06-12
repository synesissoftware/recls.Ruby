# ######################################################################### #
# File:         recls/util.rb
#
# Purpose:      Utility module functions for recls library
#
# Created:      17th February 2014
# Updated:      18th February 2015
#
# Author:       Matthew Wilson
#
# Copyright:    <<TBD>>
#
# ######################################################################### #


require File.join(File.dirname(__FILE__), 'ximpl/util')
require File.join(File.dirname(__FILE__), 'internal/common')
require File.join(File.dirname(__FILE__), 'internal/version')
require File.join(File.dirname(__FILE__), 'ximpl/os')

module Recls

	# Canonicalises the given path, by removing dots ('.' and '..')
	# directories
	def self.canonicalise_path(path)

		return Recls::Ximpl::canonicalise_path path

	end # def self.canonicalise_path

	# Derives a given path relative to an origin, unless the path is
	# absolute
	def self.derive_relative_path(origin, path)

		return Recls::Ximpl::derive_relative_path origin, path

	end # def self.derive_relative_path

end # module Recls

# ############################## end of file ############################# #


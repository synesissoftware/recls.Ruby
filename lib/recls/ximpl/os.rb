# ######################################################################### #
# File:        recls/ximpl/os.rb
#
# Purpose:     Operating system internal implementation constructs for the
#              recls library.
#
# Created:     16th February 2014
# Updated:     16th February 2014
#
# Author:      Matthew Wilson
#
# Copyright:   <<TBD>>
#
# ######################################################################### #

module Recls

	module Ximpl

		module OS

			public
			OS_IS_WINDOWS = (RUBY_PLATFORM =~ /(mswin|mingw|bccwin|wince)/i) ? true : false

			public
			PATH_SEPARATORS = OS_IS_WINDOWS ? '|;' : '|:'

			public
			WILDCARDS_ALL = OS_IS_WINDOWS ? '*.*' : '*'

		end # module OS

	end # module Ximpl

end # module Recls

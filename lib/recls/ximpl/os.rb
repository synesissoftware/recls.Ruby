# ######################################################################### #
# File:        recls/ximpl/os.rb
#
# Purpose:     Operating system internal implementation constructs for the
#              recls library.
#
# Created:     16th February 2014
# Updated:     12th October 2014
#
# Author:      Matthew Wilson
#
# Copyright:   <<TBD>>
#
# ######################################################################### #


module Recls

	module Ximpl

		module OS

			OS_IS_WINDOWS = (RUBY_PLATFORM =~ /(mswin|mingw|bccwin|wince)/i) ? true : false

			PATH_NAME_SEPARATOR = OS_IS_WINDOWS ? '\\' : '/'

			PATH_SEPARATOR = OS_IS_WINDOWS ? ';' : ':'

			WILDCARDS_ALL = OS_IS_WINDOWS ? '*' : '*'

			def OS.get_number_of_dots_dir_(p)

				if p
					if ?. == p[0]
						return 1 if 1 == p.size
						return 1 if ?/ == p[1]
						return 1 if OS_IS_WINDOWS and ?\\ == p[1]
						if ?. == p[1]
							return 2 if 2 == p.size
							return 2 if ?/ == p[2]
							return 2 if OS_IS_WINDOWS and ?\\ == p[2]
						end
					end
				end

				return 0
			end

			def OS.is_root_dir_(p)

				return nil if not p
				return true if '/' == p
				return true if OS_IS_WINDOWS and '\\' == p

				return false
			end

		end # module OS

	end # module Ximpl

end # module Recls

# ############################## end of file ############################# #

# ######################################################################### #
# File:     recls/recls.rb
#
# Purpose:	Main source file for recls library
#
# Created:	19th July 2012
# Updated:	16th February 2014
#
# Author:	Matthew Wilson
#
# Copyright:	<<TBD>>
#
# ######################################################################### #

#require File.dirname(__FILE__) + '/recls/internal/common'

require File.dirname(__FILE__) + '/filesearch'
require File.dirname(__FILE__) + '/stat'
require File.dirname(__FILE__) + '/ximpl/os'

module Recls

	# obtains the "all" wildcards string for the ambient operating
	# system
	def Recls.wildcardsAll()

		Recls::Ximpl::OS::WILDCARDS_ALL

	end # def wildcardsAll

end # module Recls

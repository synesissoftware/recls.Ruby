# ######################################################################### #
# File:         recls/version.rb
#
# Purpose:      Version for recls library
#
# Created:      14th February 2014
# Updated:      27th August 2015
#
# Author:       Matthew Wilson
#
# Copyright:    <<TBD>>
#
# ######################################################################### #


module Recls

	# Current version of the recls.Ruby library
	VERSION				=	'2.2.4'

	private
	VERSION_PARTS_		=	VERSION.split(/[.]/).collect { |n| n.to_i } # :nodoc:
	public
	VERSION_MAJOR		=	VERSION_PARTS_[0] # :nodoc:
	VERSION_MINOR		=	VERSION_PARTS_[1] # :nodoc:
	VERSION_REVISION	=	VERSION_PARTS_[2] # :nodoc:
end

# ############################## end of file ############################# #

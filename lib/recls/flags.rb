# ######################################################################### #
# File:        recls/flags.rb
#
# Purpose:     Defines the Recls::Flags module for the recls.ruby library.
#
# Created:     24th July 2012
# Updated:     16th February 2014
#
# Author:      Matthew Wilson
#
# Copyright:   <<TBD>>
#
# ######################################################################### #


module Recls

	FILES		=	0x00000001
	DIRECTORIES	=	0x00000002
	LINKS		=	0x00000004
	DEVICES		=	0x00000008

	DIR_PROGRESS	=	0x00001000
	STOP_ON_ACCESS_FAILURE=	0x00002000
	LINK_COUNT	=	0000004000
	NODE_INDEX	=	0x00008000

	RECURSIVE	=	0x00010000
	NO_FOLLOW_LINKS	=	0x00020000
	DIRECTORY_PARTS	=	0x00040000
	DETAILS_LATER	=	0x00080000

end # module Recls


# ######################################################################### #
# File:        recls/flags.rb
#
# Purpose:     Defines the Recls::Flags module for the recls.ruby library.
#
# Created:     24th July 2012
# Updated:     13th October 2014
#
# Author:      Matthew Wilson
#
# Copyright:   <<TBD>>
#
# ######################################################################### #


require File.join(File.dirname(__FILE__), 'ximpl/common')
require File.join(File.dirname(__FILE__), 'internal/version')

module Recls

	# Specifies that files are to be listed
	FILES					=	0x00000001
	# Specifies that directories are to be listed
	DIRECTORIES				=	0x00000002
	# Specifies that links are to be listed (and not followed)
	LINKS					=	0x00000004
	# Specifies that devices are to be listed
	DEVICES					=	0x00000008
	TYPEMASK				=	0x000000ff

	# Specifies that hidden items are to be shown and hidden directories are
	# to be searched
	SHOW_HIDDEN				=	0x00000100

	DIR_PROGRESS			=	0x00001000
	# Causes search to terminate if a directory cannot be entered or an
	# entry's information cannot be stat()'d
	STOP_ON_ACCESS_FAILURE	=	0x00002000
	LINK_COUNT				=	0000004000
	NODE_INDEX				=	0x00008000

	RECURSIVE				=	0x00010000
private
	NO_SEARCH_LINKS			=	0x00020000
public
	DIRECTORY_PARTS			=	0x00040000
	DETAILS_LATER			=	0x00080000

	# Causes sub-directories that are links to be searched; default is not
	# to search through links
	SEARCH_THROUGH_LINKS	=	0x00100000

end # module Recls

# ############################## end of file ############################# #

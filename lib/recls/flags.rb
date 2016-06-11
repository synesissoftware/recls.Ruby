# ######################################################################### #
# File:         recls/flags.rb
#
# Purpose:      Defines the Recls::Flags module for the recls.Ruby library.
#
# Created:      24th July 2012
# Updated:      27th August 2015
#
# Author:       Matthew Wilson
#
# Copyright (c) 2012-2015, Matthew Wilson and Synesis Software
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:
#
# * Redistributions of source code must retain the above copyright notice,
#   this list of conditions and the following disclaimer.
#
# * Redistributions in binary form must reproduce the above copyright notice,
#   this list of conditions and the following disclaimer in the documentation
#   and/or other materials provided with the distribution.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
# ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
# LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
# CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
# SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
# INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
# CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
# ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
# POSSIBILITY OF SUCH DAMAGE.
#
# ######################################################################### #


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

	MARK_DIRECTORIES		=	0x00200000

	# Causes sub-directories that are links to be searched; default is not
	# to search through links
	SEARCH_THROUGH_LINKS	=	0x00100000
end

# ############################## end of file ############################# #


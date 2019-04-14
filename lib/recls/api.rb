# ######################################################################### #
# File:         recls/api.rb
#
# Purpose:      Defines Recls module search functions
#
# Created:      9th June 2016
# Updated:      14th April 2019
#
# Author:       Matthew Wilson
#
# Copyright (c) 2016-2019, Matthew Wilson and Synesis Software
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


require 'recls/file_search'
require 'recls/flags'

=begin
=end

class Object; end # :nodoc:

module Recls

	# [DEPRECATED] Use Recls::file_search()
	def self.FileSearch(search_root, patterns, options = {})

		Recls::FileSearch.new(search_root, patterns, options)
	end

	# Initialises a +FileSearch+ instance, which acts recursively, as an
	# +Enumerable+ of Recls::Entry
	#
	# === Signature
	#
	# * *Parameters:*
	#   - +search_root+ (String, Recls::Entry) The root directory of the search. May be +nil+, in which case the current directory is assumed
	#   - +patterns+ (String, Array) The pattern(s) for which to search. May be +nil+, in which case Recls::WILDCARDS_ALL is assumed
	#   - +options+ (Hash, Integer) Combination of flags (with behaviour as described below for the +flags+ option), or an options hash
	#
	# * *Options:*
	#   - +flags+ (Integer) Combination of flags - FILES, DIRECTORIES, etc. If the value modulo TYPEMASK is 0, then FILES is assumed. The value RECURSIVE is added by the function, and so need not be added by the caller; it cannot be removed
	#
	# === Return
	# An instance of a class implementing ::Enumerable whose value type is
	# Recls::Entry
	def self.file_rsearch(search_root, patterns, options = {})

		case options
		when ::NilClass

			options	=	{ flags: RECURSIVE }
		when ::Integer

			options	|=	RECURSIVE
		when ::Hash

			flags	=	options[:flags] || 0
			flags	|=	RECURSIVE

			options[:flags]	= flags
		else

			# this is handled by the FileSearch initialiser
		end

		Recls::FileSearch.new(search_root, patterns, options)
	end

	# Initialises a +FileSearch+ instance, which acts as an +Enumerable+
	# of Recls::Entry
	#
	# === Signature
	#
	# * *Parameters:*
	#   - +search_root+ (String, Recls::Entry) The root directory of the search. May be +nil+, in which case the current directory is assumed
	#   - +patterns+ (String, Array) The pattern(s) for which to search. May be +nil+, in which case Recls::WILDCARDS_ALL is assumed
	#   - +options+ (Hash, Integer) Combination of flags (with behaviour as described below for the +flags+ option), or an options hash
	#
	# * *Options:*
	#   - +flags+ (Integer) Combination of flags - FILES, DIRECTORIES, RECURSIVE, etc. If the value modulo TYPEMASK is 0, then FILES is assumed
	#
	# === Return
	# An instance of a class implementing ::Enumerable whose value type is
	# Recls::Entry
	def self.file_search(search_root, patterns, options = {})

		Recls::FileSearch.new(search_root, patterns, options)
	end
end # module Recls

# ############################## end of file ############################# #



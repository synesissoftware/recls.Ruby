# ######################################################################### #
# File:         recls/ximpl/unix.rb
#
# Purpose:      UNIX-specific constructs for the recls library.
#
# Created:      19th February 2014
# Updated:      14th April 2019
#
# Author:       Matthew Wilson
#
# Copyright (c) 2012-2019, Matthew Wilson and Synesis Software
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


require 'recls/ximpl/util'

=begin
=end

module Recls # :nodoc:

# :stopdoc:

	module Ximpl # :nodoc: all

		# @!visibility private
		class FileStat < File::Stat # :nodoc:

			private
			# @!visibility private
			def initialize(path) # :nodoc:

				@path = path

				super(path)
			end

			public
			# @!visibility private
			attr_reader :path # :nodoc:

			# @!visibility private
			def hidden? # :nodoc:

				basename = File.basename @path

				return false if basename.empty?
				return false if '.' == basename
				return false if '..' == basename
				return false if ?. != basename[0]

				return true
			end

			public
			# @!visibility private
			def FileStat.stat(path) # :nodoc:

				Recls::Ximpl::FileStat.new(path)

			end
		end # class FileStat
	end # module Ximpl

# :startdoc:

end # module Recls

# ############################## end of file ############################# #


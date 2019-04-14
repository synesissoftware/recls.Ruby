# ######################################################################### #
# File:         recls/foreach.rb
#
# Purpose:      Definition of Recls::foreach() utility function
#
# Created:      22nd October 2014
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


require 'recls/file_search'

=begin
=end

class Object; end # :nodoc:

module Recls

	private
	class FileSearchLineEnumerator # :nodoc: all

		include Enumerable

		def initialize(fs)

			@fs = fs
		end

		def each(&block)

			@fs.each do |fe|

				IO.readlines(fe).each_with_index do |line, index|

					case	block.arity
					when	1
						yield line
					when	2
						yield line, index
					when	3
						yield line, index, fe
					else
						raise ArgumentError, "block must take 1, 2, or 3 parameters - #{block.arity} given. (Perhaps you have applied each_with_index, which cannot be done to Recls.foreach)"
					end
				end
			end
		end
	end # class FileSearchLineEnumerator
	public

	# Performs a recursive search and enumerates the lines of all files
	# found
	#
	# === Signature
	#
	# * *Parameters:*
	#   - +searchable+ A searchable instance obtained from Recls::file_search() or Recls::file_rsearch()
	#   - +search_root+ (String, Recls::Entry) The root directory of the search. May be +nil+, in which case the current directory is assumed
	#   - +patterns+ (String, Array) The pattern(s) for which to search. May be +nil+, in which case Recls::WILDCARDS_ALL is assumed
	#   - +options+ (Hash) An options hash
	#   - +flags+ (Integer) Combination of flags (with behaviour as described below for the +flags+ option)
	#
	# * *Block:*
	# An optional block that will be executed once for each line in each file
	# found, where the block must take 1, 2, or 3 parameters, representing the
	# line [ + file-line-index [ + entry ]]. If no block is given, an
	# enumerator is returned.
	#
	# ==== Parameter Ordering
	#
	# The parameters may be expressed in any of the following permutations:
	# - +searchable+
	# - +search_root+, +patterns+, +flags+
	# - +search_root+, +patterns+, +options+
	#
	# === Return
	#
	def self.foreach(*args, &block)

		fs = nil

		case	args.length
		when	1
			raise ArgumentError "Single argument must be of type #{Recls::FileSearch}" unless args[0].kind_of? Recls::FileSearch

			fs = args[0]
		when	3
			fs = Recls::FileSearch.new(args[0], args[1], args[2])
		else
			raise ArgumentError "Function requires single argument (#{Recls::FileSearch}) or three arguments (directory, patterns, flags)"
		end

		if block_given?

			FileSearchLineEnumerator.new(fs).each(block)

			return nil
		else

			return FileSearchLineEnumerator.new(fs)
		end
	end
end # module Recls

# ############################## end of file ############################# #



# ######################################################################### #
# File:         recls/foreach.rb
#
# Purpose:      Definition of Recls::foreach() utility function
#
# Created:      22nd October 2014
# Updated:      22nd October 2014
#
# Author:       Matthew Wilson
#
# Copyright:    <<TBD>>
#
# ######################################################################### #


require File.join(File.dirname(__FILE__), 'filesearch')

module Recls

	private
	class FileSearchLineEnumerator

		def initialize(fs)

			@fs = fs

		end # def initialize

		def each(&block)

			@fs.each do |fe|

				IO::readlines(fe).each_with_index do |line, index|

					case	block.arity
					when	1
						yield line
					when	2
						yield index, line
					when	3
						yield fe, index, line
					else
						raise ArgumentError "block must take 1, 2, or 3 parameters"
					end
				end
			end
		end # def each

	end # class FileSearchLineEnumerator
	public

	def Recls.foreach(fs, &block)

		if block_given?

			FileSearchLineEnumerator.new(fs).each(block)

			return nil

		else

			return FileSearchLineEnumerator.new(fs)

		end
	end # def Recls.foreach

end # module Recls

# ############################## end of file ############################# #


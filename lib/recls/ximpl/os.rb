# ######################################################################## #
# File:     recls/ximpl/os.rb
#
# Purpose:  Operating system internal implementation constructs for the
#           recls library.
#
# Created:  16th February 2014
# Updated:  20th April 2024
#
# Author:   Matthew Wilson
#
# Copyright (c) 2019-2024, Matthew Wilson and Synesis Information Systems
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
# ######################################################################## #


=begin
=end

module Recls # :nodoc:

# :stopdoc:

  # @!visibility private
  module Ximpl # :nodoc: all

    module OS # :nodoc: all

      # @!visibility private
      OS_IS_WINDOWS = (RUBY_PLATFORM =~ /(mswin|mingw|bccwin|wince)/i) ? true : false

      # @!visibility private
      PATH_NAME_SEPARATOR = OS_IS_WINDOWS ? '\\' : '/'

      # @!visibility private
      PATH_SEPARATOR = OS_IS_WINDOWS ? ';' : ':'

      # @!visibility private
      WILDCARDS_ALL = OS_IS_WINDOWS ? '*' : '*'

      # @!visibility private
      def OS.get_number_of_dots_dir_(p) # :nodoc:

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

      # @!visibility private
      def OS.is_root_dir_(p) # :nodoc:

        return nil if not p
        return true if '/' == p
        return true if OS_IS_WINDOWS and '\\' == p

        return false
      end
    end # module OS
  end # module Ximpl

# :startdoc:

end # module Recls


# ############################## end of file ############################# #


# ######################################################################## #
# File:     recls/stat.rb
#
# Purpose:  Defines the Recls.stat() method for the recls.Ruby library.
#
# Created:  24th July 2012
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


require 'recls/entry'
require 'recls/flags'


=begin
=end

# @!visibility private
class Object; end # :nodoc:

module Recls

  # Equivalent to a Recls::stat() but only returns (a non-+nil+ value) if the
  # path exists _and_ represents a directory
  #
  # This has two advantages over +File.directory?+: it obtains a
  # Recls::Entry in the case where the path represents a directory; and
  # it does '~' interpretation
  #
  # === Signature
  #
  # * *Parameters:*
  #   - +path+ (+String+, +Recls::Entry+) The path;
  #
  # === Return
  # (+Recls::Entry+, +nil+) The entry if +path+ exists and is a directory; +nil+ otherwise.
  def self.directory?(path, *args)

    fe = self.stat(path, *args)

    if fe

      return nil unless fe.directory?
    end

    fe
  end

  # Equivalent to a Recls::stat() but only returns (a non-+nil+ value) if the
  # path exists _and_ represents a file
  #
  # This has two advantages over +File.file?+: it obtains a
  # Recls::Entry in the case where the path represents a file; and
  # it does '~' interpretation
  #
  # === Signature
  #
  # * *Parameters:*
  #   - +path+ (+String+, +Recls::Entry+) The path;
  #
  # === Return
  # (+Recls::Entry+, +nil+) The entry if +path+ exists and is a file; +nil+ otherwise.
  def self.file?(path, *args)

    fe = self.stat(path, *args)

    if fe

      return nil unless fe.file?
    end

    fe
  end

  # Obtains a single Recls::Entry instance from a path, according to the
  # given arguments, which can be any combination of search-root and
  # flags, as discussed below
  #
  # === Signature
  #
  # * *Parameters:*
  #   - +path+ (+String+) A path to evaluate. May not be +nil+;
  #   - +search_root+ (+String+, +Recls::Entry+) A directory from which the returned Entry instance's search-relative attributes are evaluated;
  #   - +flags+ (+Integer+) A bit-combined set of flags (such as +Recls::DIRECTORIES+, +Recls::FILES+, +Recls::RECURSIVE+, +Recls::DETAILS_LATER+, and so on);
  #
  # ==== Parameter Ordering
  #
  # The parameters may be expressed in any of the following permutations:
  # - +path+
  # - +path+, +flags+
  # - +path+, +search_root+
  # - +path+, +flags+, +search_root+
  # - +path+, +search_root+, +flags+
  #
  # === Return
  # (+Recls::Entry+) An entry representing the path on the file-system, or
  # +nil+ if the path does not refer to an existing entity. If the
  # +Recls::DETAILS_LATER+ flag is included, then an entry is returned
  # regardless of its existence.
  def self.stat(path, *args)

    flags       = 0
    search_root = nil
    message     = nil

    path = File.expand_path(path) if path =~ /^~[\\\/]*/

    case args.size
    when 0

      ;
    when 1

      case args[0]
      when ::Integer

        flags = args[0]
      when ::String

        search_root = args[0]
      else

        message = "argument '#{args[0]}' (#{args[0].class}) not valid"
      end
    when 2

      if false
      elsif ::Integer === args[0] && ::String === args[1]

        flags       = args[0]
        search_root = args[1]
      elsif ::String === args[0] && ::Integer === args[1]

        search_root = args[0]
        flags       = args[1]
      else

        message = "invalid combination of arguments"
      end
    else

      message = "too many arguments"
    end

    raise ArgumentError, "#{message}: Recls.stat() takes one (path), two (path+flags or path+search_root), or three (path+search_root+flags) arguments" if message

    Recls::Ximpl.stat_prep(path, search_root, flags)
  end
end # module Recls


# ############################## end of file ############################# #


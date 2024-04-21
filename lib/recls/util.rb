# ######################################################################## #
# File:     recls/util.rb
#
# Purpose:  Utility module functions for recls library
#
# Created:  17th February 2014
# Updated:  21st April 2024
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


require 'recls/stat'
require 'recls/ximpl/util'
require 'recls/ximpl/os'


=begin
=end

module Recls

  # Obtains the absolute form of the given path
  #
  # === Signature
  #
  # * *Parameters:*
  #   - +path+ (+String+, {Recls::Entry}) The path;
  #
  # === Return
  # (+String+) The absolute form of the path.
  def self.absolute_path(path)

    Recls::Ximpl.absolute_path path
  end

  # Canonicalises the given path, by removing dots directories,
  # i.e. +'.'+ and +'..'+
  #
  # === Signature
  #
  # * *Parameters:*
  #   - +path+ (+String+, {Recls::Entry}) The path;
  #
  # === Return
  # (+String+) The canonical form of the path.
  def self.canonicalise_path(path)

    return path.path if ::Recls::Entry === path

    Recls::Ximpl.canonicalise_path path
  end

  # Derives a given path relative to an origin, unless the path is
  # absolute
  #
  # === Signature
  #
  # * *Parameters:*
  #   - +origin+ (+String+, {Recls::Entry}) The path against which +path+ will be evaluated;
  #   - +path+ (+String+, {Recls::Entry}) The path to evaluate;
  #
  # === Return
  # (+String+) The relative form of the path.
  def self.derive_relative_path(origin, path)

    Recls::Ximpl.derive_relative_path origin, path
  end
end # module Recls

if RUBY_VERSION >= '2'

  require 'recls/combine_paths_2plus'
else

  require 'recls/combine_paths_1'
end

module Recls

  # Indicates whether the given path exists, obtaining a {Recls::Entry}
  # instance if so
  #
  # === Signature
  #
  # * *Parameters:*
  #   - +path+ (+String+, {Recls::Entry}) The path;
  #
  # === Return
  # ({Recls::Entry}, +nil+) The entry if +path+ exists; +nil+ otherwise.
  def self.exist?(path)

    return nil if path.nil?

    Recls.stat(path)
  end

  # Indicates whether the given path is absolute
  #
  # === Signature
  #
  # * *Parameters:*
  #   - +path+ (+String+, {Recls::Entry}, +nil+) The path to be evaluated;
  #
  # === Return
  # (boolean) +true+ if +path+ is absolute; +false+ otherwise.
  def self.absolute_path?(path)

    Recls::Ximpl.absolute_path? path
  end
end # module Recls


# ############################## end of file ############################# #


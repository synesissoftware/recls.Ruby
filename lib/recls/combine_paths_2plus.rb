# ######################################################################## #
# File:     recls/compare_paths_2plus.rb
#
# Purpose:  Definition of Recls::compare_paths() for Ruby 2+
#
# Created:  17th February 2014
# Updated:  9th January 2025
#
# Author:   Matthew Wilson
#
# Copyright (c) 2019-2025, Matthew Wilson and Synesis Information Systems
# Copyright (c) 2014-2019, Matthew Wilson and Synesis Software
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


require 'recls/ximpl/util'


=begin
=end

module Recls

  # Combines paths, optionally canonicalising them.
  #
  # Unlike `File::join()`, this method takes account of relative vs absolute
  # elements in the sequence. Specifically, the rightmost non-relative
  # element, if it exists, anchors the combination, such that any arguments
  # to the left are ignored. Furthermore, any entries (of type
  # `Recls::Entry`) in the sequence are given special treatment as follows:
  # - a rightmost `#file?` or `#device?` is returned as the complete result;
  # - a rightmost `#directory?` causes all prior elements to be ignored and
  #   may be combined with subsequent elements;
  #
  # === Signature
  #
  # * *Parameters:*
  #   - +paths+ ( +String+, {Recls::Entry} ) Array of 1 or more path elements to be combined;
  #   - +options+ (+Hash+) Options that moderate the combination;
  #
  # * *Options:*
  #   - +:canonicalise+ (boolean) Causes the evaluated path to be canonicalised - with +Recls.canonicalise_path+ - before it is returned;
  #   - +:clean+ (boolean) Causes the evaluated path to be cleaned (i.e. sent to +cleanpath+) before it is returned. Ignored if +:canonicalise+ is specified;
  #   - +:clean_path+ (boolean) Equivalent to +:clean+, but deprecated and may be removed in a future version;
  #
  # === Return
  # (+String+) The combined path.
  def self.combine_paths(*paths, **options)

    paths.reject! { |p| p.nil? }

    raise ArgumentError, 'must specify one or more path elements' if paths.empty?

    ix_last_entry = paths.rindex { |path| ::Recls::Entry === path }

    if ix_last_entry

      fe = paths[ix_last_entry]

      if fe.directory?

        paths = paths[ix_last_entry..]
      else

        return fe
      end
    end

    paths = paths.map { |path| path.to_str }

    return Recls::Ximpl.combine_paths paths, options
  end
end # module Recls


# ############################## end of file ############################# #


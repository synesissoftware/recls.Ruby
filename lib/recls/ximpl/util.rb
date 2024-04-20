# ######################################################################## #
# File:     recls/ximpl/util.rb
#
# Purpose:  Internal implementation constructs for the recls library.
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


require 'recls/ximpl/os'
require 'recls/flags'

require 'pathname'


=begin
=end

module Recls # :nodoc:

# :stopdoc:

  module Ximpl # :nodoc: all

    module Util # :nodoc: all

      # @!visibility private
      def self.is_path_name_separator(c) # :nodoc:

        return true if ?/ == c

        if Recls::Ximpl::OS::OS_IS_WINDOWS

          return true if ?\\ == c
        end

        return false
      end

      # Indicates whether a trailing slash is on the given path
      #
      # dependencies: none
      #
      # @!visibility private
      def self.has_trailing_slash(p) # :nodoc:

        return p if p.nil? or p.empty?

        return self.is_path_name_separator(p[-1])
      end

      # returns the trailing slash, or nil if none present
      #
      # dependencies: none
      #
      # @!visibility private
      def self.get_trailing_slash(p, args = {}) # :nodoc:

        return nil if p.nil?
        return nil if p.empty?

        return self.is_path_name_separator(p[-1]) ? p[-1] : nil
      end

      # appends trailing slash to a path if not already
      # present
      #
      # dependencies: none
      #
      # @!visibility private
      def self.append_trailing_slash(p, slash = nil) # :nodoc:

        return p if not p or p.empty?

        return p if self.is_path_name_separator(p[-1])

        slash = '/' if not slash

        "#{p}#{slash}"
      end

      # trims trailing slash from a path, unless it is the
      # root
      #
      # dependencies: none
      #
      # @!visibility private
      def self.trim_trailing_slash(p) # :nodoc:

        return p if not p or p.empty?

        p = p[0 ... -1] if self.is_path_name_separator(p[-1])

        return p
      end

      # From path p, returns a tuple containing either:
      #
      #  [ nil, p ] if p does not contain a Windows root, or
      #
      #  [ wroot, remainder ] if p does contain a Windows root, or
      #
      #  [ nil, nil ] if p is nil
      #
      # dependencies: none
      #
      # @!visibility private
      def self.get_windows_root(p) # :nodoc:

        return [ nil, nil ] if not p

        if Recls::Ximpl::OS::OS_IS_WINDOWS

          # Windows local drive (e.g. 'H:')
          #
          # NOTE: this works for both rooted and unrooted paths
          if p =~ /^([a-zA-Z]:)/

            return [ $1, $' ]
          end

          # UNC network drive
          #
          # NOTE: there are several permutations ...
          if p =~ /^(\\\\[^\\\/:*?<>|]+\\[^\\\/:*?<>|]+)([\\\/].*)$/

            # \\server\share{\{... rest of path}}
            return [ $1, $2 ]
          end
          if p =~ /^(\\\\[^\\\/:*?<>|]+\\[^\\\/:*?<>|]+)$/

            # \\server\share
            return [ $1, nil ]
          end
          if p =~ /^(\\\\[^\\\/:*?<>|]+\\)$/

            # \\server\
            return [ $1, nil ]
          end
          if p =~ /^(\\\\[^\\\/:*?<>|]+)$/

            # \\server
            return [ $1, nil ]
          end
        end

        return [ nil, p ]
      end

      # obtains the parts from a path, including any Windows root and
      # the file basename
      #
      # @!visibility private
      def self.path_parts(path) # :nodoc:

        return nil if path.nil?
        return [] if path.empty?

        parts = []

        wr, rem =  self.get_windows_root(path)

        parts << wr if wr

        until rem.nil? || rem.empty?

          if rem =~ /^([^\\\/]*[\\\/])/

            parts << $1
            rem = $'
          else

            parts << rem
            rem = ''
          end
        end

        parts
      end

      # Returns a tuple consisting of the following
      # elements (or nil, for any element that is not)
      # present
      #
      # f1. Windows root, or nil
      # f2. directory, or nil
      # f3. basename, or nil
      # f4. basename-minus-extension, or nil
      # f5. extension, or nil
      # f6. array of directory path parts, which may be empty (not nil)
      # f7. array of all path parts, which may be empty (not nil)
      #
      # dependencies: Util.path_parts, Util.get_windows_root
      #
      # @!visibility private
      def self.split_path(p) # :nodoc:

        f1_windows_root, remainder = self.get_windows_root p
        f1_windows_root = nil if not f1_windows_root or f1_windows_root.empty?
        remainder = nil if not remainder or remainder.empty?

        if not remainder or remainder.empty?

          f2_directory = nil
          f3_basename = nil
          f4_nameonly = nil
          f5_extension = nil
        else

          if remainder =~ /^(.*[\\\/])([^\\\/]*)$/

            f2_directory = $1
            f3_basename = $2
          else

            f2_directory = nil
            f3_basename = remainder
            f4_nameonly = nil
            f5_extension = nil
          end

          f2_directory = nil if not f2_directory or f2_directory.empty?
          f3_basename = nil if not f3_basename or f3_basename.empty?

          if f3_basename

            # special case: treat '.' and '..' as file-name only
            if '.' == f3_basename or '..' == f3_basename

              f4_nameonly = f3_basename
              f5_extension = nil
            elsif f3_basename =~ /^(.*)(\.[^.]*)$/

              f4_nameonly = $1
              f5_extension = $2
            else

              f4_nameonly = f3_basename
              f5_extension = nil
            end
          else

            f4_nameonly = nil
            f5_extension = nil
          end
        end

        f4_nameonly = nil if not f4_nameonly or f4_nameonly.empty?
        f5_extension = nil if not f5_extension or f5_extension.empty?
        f6_directory_parts = self.path_parts(f2_directory)
        f7_path_parts = self.path_parts(p)

        return [ f1_windows_root, f2_directory, f3_basename, f4_nameonly, f5_extension, f6_directory_parts, f7_path_parts ]
      end

      # Returns a tuple consisting of:
      #
      # f1. The canonicalised array of parts
      # f2. A boolean indicating whether to 'consume' the basename
      #
      # dependencies: OS.is_root_dir_, OS.get_number_of_dots_dir_,
      #
      # @!visibility private
      def self.canonicalise_parts(parts, basename = nil) # :nodoc:

        newParts = []

        lastSingleDots = nil

        path_is_rooted = nil

        index = -1
        parts.each do |part|

          index += 1

          next if not part
          next if part.empty?

          if path_is_rooted.nil?

            path_is_rooted = self.is_path_name_separator(part[0])
          end

          if ?. == part[0]

            if self.is_path_name_separator(part[1])

              # single dots, so ...

              # ... remember the last instance, and ...
              lastSingleDots = part

              # ... skip to leave this out of the result
              next
            elsif ?. == part[1]

              if self.is_path_name_separator(part[2])

                # double dots, so ...
                # ... skip this and pop prior from the new list iff:
                #
                # 1. there is a prior elements in the new list (size > 1); AND
                # 2. the last element in the new list is not the root directory; AND
                # 3. the last element in the list is not a dots directory
                if not newParts.empty? # 1.

                  priorPart = newParts[-1]
                  if 1 == newParts.size and OS.is_root_dir_(priorPart)

                    # 2.
                    next
                  else

                    dirtype = OS.get_number_of_dots_dir_(priorPart)
                    if 0 == dirtype # 3.

                      if newParts.pop

                        next
                      end
                    end
                  end
                end
              else

                # it's a ..X part
              end
            else

              # it's a .X part
            end
          else

            # it's a non-dots part
          end

          newParts << part
        end

        consume_basename = false

        if basename

          if ?. == basename[0]

            if 1 == basename.size

              # single dots
              if newParts.empty?

                lastSingleDots = false
              else

                consume_basename = true
              end
            elsif ?. == basename[1] and 2 == basename.size

              # double dots, so ...
              #
              # ... pop unless we already have some outstanding double dots
              if newParts.empty?

                newParts << '..'
                consume_basename = true
              elsif 1 == newParts.size && 1 == newParts[0].size && Util.is_path_name_separator(newParts[0][0])

                consume_basename = true
              else

                if 2 != OS.get_number_of_dots_dir_(newParts[-1])

                  newParts.pop
                  consume_basename = true
                end
              end
            end
          end
        end

        # push lastSingleDots (which may contain a trailing slash) if
        # exists and newParts is empty
        newParts << lastSingleDots if lastSingleDots and newParts.empty?

        if not newParts.empty?

          if 2 == OS.get_number_of_dots_dir_(newParts[-1])

            # the last element is the double-dots directory, but
            # need to determine whether to ensure/remote a
            # trailing slash
            if basename and not basename.empty?

              if not consume_basename

                # leave as is
              else

                newParts[-1] = '..'
              end
            end
          end
        else

          # handle case where all (double)-dots have eliminated
          # all regular directories
          if not basename or basename.empty? or consume_basename

            newParts << '.'
          end
        end

        [ newParts.join(''), consume_basename ]
      end
    end # module Util

    # Canonicalises a path
    #
    # Note: contains a trailing slash if, in the context of the given
    # path, the last element of the canonicalised path is a directory
    # unequivocally
    #
    # @!visibility private
    def self.canonicalise_path(path) # :nodoc:

      raise ArgumentError, "`path` must be an instance of `::String` or `nil`" if $DEBUG && !path.nil? && !path.is_a?(::String)

      return nil if not path
      return '' if path.empty?

      path = File.expand_path(path) if '~' == path[0].to_s

      f1_windows_root, f2_directory, f3_basename, dummy1, dummy2, directory_parts, dummy3 = Util.split_path(path)

      # suppress unused warnings
      dummy1 = dummy1
      dummy2 = dummy2
      dummy3 = dummy3

      if not f2_directory

        canonicalised_directory = nil
      else

        canonicalised_directory, consume_basename = Util.canonicalise_parts(directory_parts, f3_basename)
        f3_basename = nil if consume_basename
      end

      return "#{f1_windows_root}#{canonicalised_directory}#{f3_basename}"
    end

    # @!visibility private
    def self.absolute_path?(path) # :nodoc:

      case path
      when nil

        return nil
      when ::String

        return nil if path.empty?

        path = File.expand_path(path) if '~' == path[0]
      when ::Recls::Entry

        return path
      else

        raise TypeError, "parameter path ('#{path}') is of type `#{path.class}` must be `nil` or an instance of `#{::String}` or `#{::Recls::Entry}`"
      end

      f1_windows_root, f2_directory, dummy1, dummy2, dummy3, dummy4, dummy5 = Util.split_path(path)

      dummy1 = dummy2 = dummy3 = dummy4 = dummy5 = nil

      unless f1_windows_root

        return nil unless f2_directory

        return nil unless Util.is_path_name_separator(f2_directory[0])
      end

      Recls::Ximpl.stat_prep(path, nil, Recls::DETAILS_LATER)
    end

    # determines the absolute path of a given path
    #
    # @!visibility private
    def self.absolute_path(path, refdir = nil) # :nodoc:

      case path
      when ::NilClass

        return nil
      when ::String

        path = File.expand_path(path) if '~' == path[0]
      when ::Recls::Entry

        return path.path
      else

        raise TypeError, "parameter path ('#{path}') is of type `#{path.class}` must be an instance of `#{::String}` or `#{::Recls::Entry}`"
      end

      return '' if path.empty?

      dummy1, f2_directory, dummy2, dummy3, dummy4, dummy5, dummy6 = Util.split_path(path)

      # suppress unused warnings
      dummy1 = dummy1
      dummy2 = dummy2
      dummy3 = dummy3
      dummy4 = dummy4
      dummy5 = dummy5
      dummy6 = dummy6

      if f2_directory =~ /^[\\\/]/

        return path
      end

      cwd = refdir ? refdir : Dir.getwd

      trailing_slash = Util.get_trailing_slash(path)

      if '.' == path

        return Util.trim_trailing_slash cwd
      elsif 2 == path.size and trailing_slash

        return Util.append_trailing_slash(cwd, path[1..1])
      end

      cwd = Util.append_trailing_slash(cwd)

      path = "#{cwd}#{path}"

      path = canonicalise_path path

      if trailing_slash

        path = Util.append_trailing_slash path, trailing_slash
      else

        path = Util.trim_trailing_slash path
      end

      path
    end

    # obtains the basename of a path, e.g.
    # the basename of
    #  abc/def/ghi.jkl
    # or (on Windows)
    #  C:\abc\def\ghi.jkl
    # is
    #  ghi.jkl
    #
    # @!visibility private
    def self.basename(path) # :nodoc:

      return nil if not path

      # NOTE: we don't implement in terms of split_path
      # because all but the UNC case work with just
      # detecting the last (back)slash

      if Recls::Ximpl::OS::OS_IS_WINDOWS

        wr, rem = Util.get_windows_root(path)

        # suppress unused warning
        wr = wr

        if not rem

          return ''
        else

          path = rem
        end
      end

      if not path.is_a? String

        path = path.to_s
      end

      if path =~ /^.*[\/\\](.*)/

        $1
      else

        path
      end
    end

    # obtains the file extension of a basename, e.g.
    # the file_ext of
    #  ghi.jkl
    # is
    #  .jkl
    #
    # @!visibility private
    def self.file_ext(path) # :nodoc:

      return nil if not path

      use_split_path = false

      if Recls::Ximpl::OS::OS_IS_WINDOWS

        if path.include? ?\\

          use_split_path = true
        end
      end

      if path.include? ?/

        use_split_path = true
      end

      if use_split_path

        ext = Util.split_path(path)[4]
      else

        if path =~ /^.*(\.[^.]*)$/

          ext = $1
        else

          ext = nil
        end
      end

      return ext ? ext : ''
    end

    # obtains the directory from the directory path
    #
    # @!visibility private
    def self.directory_from_directory_path(directory_path) # :nodoc:

      wr, rem =  Util.get_windows_root(directory_path)

      # suppress unused warning
      wr = wr

      rem
    end

    # obtains the directory parts from a directory
    #
    # @!visibility private
    def self.directory_parts_from_directory(directory) # :nodoc:

      return nil if not directory

      directory_parts = []

      until directory.empty?

        if directory =~ /^([^\\\/]*[\\\/])/

          directory_parts << $1
          directory = $'
        else

          directory_parts << directory
          directory = ''
        end
      end

      directory_parts
    end

    # obtains the relative path of a given path and
    # a reference directory
    #
    # @!visibility private
    def self.derive_relative_path(origin, path) # :nodoc:

      return nil if path.nil?
      return nil if path.empty?
      return path if origin.nil?
      return path if origin.empty?

      path    = self.canonicalise_path path
      origin  = self.canonicalise_path origin

      path    = self.absolute_path path
      origin  = self.absolute_path origin

      return path if /^\.[\\\/]*$/ =~ origin

      path_splits   = Util.split_path(path)
      origin_splits = Util.split_path(origin)

      # if different windows root, then cannot provide relative

      if path_splits[0] and origin_splits[0]

        return path if path_splits[0] != origin_splits[0]
      end

      trailing_slash  = Util.get_trailing_slash(path)

      path_parts      = path_splits[6]
      origin_parts    = origin_splits[6]

      loop do

        break if path_parts.empty?
        break if origin_parts.empty?

        path_part   = path_parts[0]
        origin_part = origin_parts[0]

        if 1 == path_parts.size || 1 == origin_parts.size

          path_part   = Util.append_trailing_slash(path_part)
          origin_part = Util.append_trailing_slash(origin_part)
        end

        if path_part == origin_part

          path_parts.shift
          origin_parts.shift
        else

          break
        end
      end

      return ".#{trailing_slash}" if path_parts.empty? and origin_parts.empty?

      # at this point, all reference parts should be converted into '..'

      return origin_parts.map { |rp| '..' }.join('/') if path_parts.empty?

      return '../' * origin_parts.size + path_parts.join('')
    end

    # @!visibility private
    def self.combine_paths(paths, options) # :nodoc:

      raise ArgumentError, "`paths` must be an instance of `::Array`" if $DEBUG && !paths.is_a?(::Array)
      raise ArgumentError, "`paths` elements must be instances of `::String`" if $DEBUG && paths.any? { |s| !s.is_a?(::String) }

      abs_ix  = 0

      paths = paths.map { |path| '~' == path[0].to_s ? File.expand_path(path) : path }

      paths.each_with_index do |path, index|

        dummy1, f2_directory, dummy2, dummy3, dummy4, dummy5, dummy6 = Util.split_path(path)

        # suppress unused warnings
        dummy1 = dummy1
        dummy2 = dummy2
        dummy3 = dummy3
        dummy4 = dummy4
        dummy5 = dummy5
        dummy6 = dummy6

        if f2_directory && Util.is_path_name_separator(f2_directory[0])

          abs_ix = index
        end
      end

      paths = paths[abs_ix..-1]

      r = File.join(*paths)

      cap = options[:canonicalise] || options[:canonicalize]

      if cap

        r = Recls.canonicalise_path r
      else

        clp = options[:clean] || options[:clean_path]

        if clp

          r = Pathname.new(r).cleanpath.to_s
        end
      end

      r
    end


    # Elicits the contents of the given directory, or, if the flag
    # STOP_ON_ACCESS_FAILURE is specified throws an exception if the
    # directory does not exist
    #
    # Some known conditions:
    #
    # * (Mac OSX) /dev/fd/<N> - some of these stat() as directories but
    #    Dir.new fails with ENOTDIR
    #
    # @!visibility private
    def self.dir_entries_maybe(dir, flags) # :nodoc:

      begin

        Dir.new(dir).to_a

      rescue SystemCallError => x

        $stderr.puts "exception (`#{x.class}`): #{x}" if $DEBUG

        if(0 != (STOP_ON_ACCESS_FAILURE & flags))

          raise
        end

        return []
      end
    end

    # @!visibility private
    def self.stat_prep(path, search_root, flags) # :nodoc:

      begin

        Recls::Entry.new(path, Recls::Ximpl::FileStat.stat(path), search_root, flags)
      rescue Errno::ENOENT, Errno::ENXIO => x

        x = x # suppress warning

        if 0 != (flags & Recls::DETAILS_LATER)

          Recls::Entry.new(path, nil, search_root, flags)
        else

          nil
        end
      end
    end
  end # module Ximpl

# :startdoc:

end # module Recls


# ############################## end of file ############################# #


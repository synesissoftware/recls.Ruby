# ######################################################################## #
# File:     recls/ximpl/windows.rb
#
# Purpose:  Windows-specific constructs for the recls library.
#
# Created:  19th February 2014
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


require 'Win32API'


=begin
=end

# :stopdoc:

module Recls # :nodoc:

  # @!visibility private
  module Ximpl # :nodoc: all

    # @!visibility private
    class FileStat < File::Stat # :nodoc:

      private
      GetFileAttributes           = Win32API.new('kernel32', 'GetFileAttributes', [ 'P' ], 'I')
      GetFileInformationByHandle  = Win32API.new('kernel32', 'GetFileInformationByHandle', [ 'L', 'P' ], 'I')
      GetShortPathName            = Win32API.new('kernel32', 'GetShortPathName', [ 'P', 'P', 'L' ], 'L')
      CreateFile                  = Win32API.new('kernel32', 'CreateFile', [ 'P', 'L', 'L', 'L', 'L', 'L', 'L' ], 'L')
      CloseHandle                 = Win32API.new('kernel32', 'CloseHandle', [ 'L' ], 'L')
      FILE_ATTRIBUTE_READONLY     = 0x00000001
      FILE_ATTRIBUTE_HIDDEN       = 0x00000002
      FILE_ATTRIBUTE_SYSTEM       = 0x00000004
      FILE_ATTRIBUTE_DIRECTORY    = 0x00000010
      FILE_ATTRIBUTE_ARCHIVE      = 0x00000020
      FILE_ATTRIBUTE_DEVICE       = 0x00000040
      FILE_ATTRIBUTE_NORMAL       = 0x00000080
      FILE_ATTRIBUTE_TEMPORARY    = 0x00000100
      FILE_ATTRIBUTE_COMPRESSED   = 0x00000800
      FILE_ATTRIBUTE_ENCRYPTED    = 0x00004000

      OPEN_EXISTING               = 0x00000003
      FILE_FLAG_OVERLAPPED        = 0x40000000
      NULL                        = 0x00000000
      INVALID_HANDLE_VALUE        = 0xFFFFFFFF

      MAX_PATH                    = 260

      BHFI_pack_string            = 'LQQQLLLLLL'

      # @!visibility private
      class ByHandleInformation # :nodoc:

        # @!visibility private
        def initialize(path) # :nodoc:

          @volume_id  = 0
          @file_index = 0
          @num_links  = 0

          # for some reason not forcing this new string causes 'can't modify frozen string (TypeError)' (in Ruby 1.8.x)
          hFile = CreateFile.call("#{path}", 0, 0, NULL, OPEN_EXISTING, 0, NULL);
          if INVALID_HANDLE_VALUE != hFile

            begin
              bhfi  = [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ]
              bhfi  = bhfi.pack(BHFI_pack_string)

              if GetFileInformationByHandle.call(hFile, bhfi)

                bhfi = bhfi.unpack(BHFI_pack_string)

                @volume_id  = bhfi[4]
                @file_index = (bhfi[8] << 32) | bhfi[9]
                @num_links  = bhfi[7]
              else
              end
            ensure
              CloseHandle.call(hFile)
            end
          end
        end

        # @!visibility private
        attr_reader :volume_id
        # @!visibility private
        attr_reader :file_index
        # @!visibility private
        attr_reader :num_links
      end

      private
      # @!visibility private
      def has_attribute_? (attr) # :nodoc:

        0 != (attr & @attributes)
      end

      private
      # @!visibility private
      def initialize(path) # :nodoc:

        @path = path

        # for some reason not forcing this new string causes 'can't modify frozen string (TypeError)'
        attributes = GetFileAttributes.call("#{path}")

        if 0xffffffff == attributes

          @attributes = 0
        else

          @attributes = attributes
        end

        super(path)

        @by_handle_information = ByHandleInformation.new(path)

        buff = ' ' * MAX_PATH
        # not forcing this new string causes 'can't modify frozen string (TypeError)'
        n = GetShortPathName.call("#{path}", buff, buff.length)
        @short_path = (0 == n) ? nil : buff[0...n]
      end

      public
      # @!visibility private
      attr_reader :attributes
      # @!visibility private
      attr_reader :path
      # @!visibility private
      attr_reader :by_handle_information
      # @!visibility private
      attr_reader :short_path

      # @!visibility private
      def hidden? # :nodoc:

        0 != (FILE_ATTRIBUTE_HIDDEN & @attributes)
      end

      # Windows-specific attributes

      # @!visibility private
      def system? # :nodoc:

        has_attribute_? FILE_ATTRIBUTE_SYSTEM
      end

      # @!visibility private
      def archive? # :nodoc:

        has_attribute_? FILE_ATTRIBUTE_ARCHIVE
      end

      # @!visibility private
      def device? # :nodoc:

        has_attribute_? FILE_ATTRIBUTE_DEVICE
      end

      # @!visibility private
      def normal? # :nodoc:

        has_attribute_? FILE_ATTRIBUTE_NORMAL
      end

      # @!visibility private
      def temporary? # :nodoc:

        has_attribute_? FILE_ATTRIBUTE_TEMPORARY
      end

      # @!visibility private
      def compressed? # :nodoc:

        has_attribute_? FILE_ATTRIBUTE_COMPRESSED
      end

      # @!visibility private
      def encrypted? # :nodoc:

        has_attribute_? FILE_ATTRIBUTE_ENCRYPTED
      end


      public
      # @!visibility private
      def FileStat.stat(path) # :nodoc:

        Recls::Ximpl::FileStat.new(path)
      end
    end # class FileStat
  end # module Ximpl
end # module Recls

# :startdoc:


# ############################## end of file ############################# #


# ######################################################################## #
# File:     recls/ximpl/windows.rb
#
# Purpose:  Windows-specific constructs for the recls library.
#
# Created:  19th February 2014
# Updated:  2nd June 2024
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

module Recls

  # @!visibility private
  module Ximpl # :nodoc: all

    # @!visibility private
    module Kernel32

      INVALID_HANDLE_VALUE        = 0xFFFFFFFF
      MAX_PATH                    = 260
      NULL                        = 0x00000000
      OPEN_EXISTING               = 0x00000003
    end # module Kernel32

    module Kernel32

      CloseHandle                 = Win32API.new('kernel32', 'CloseHandle', [ 'L' ], 'L')
      CreateFile                  = Win32API.new('kernel32', 'CreateFile', [ 'P', 'L', 'L', 'L', 'L', 'L', 'L' ], 'L')
      GetFileAttributes           = Win32API.new('kernel32', 'GetFileAttributes', [ 'P' ], 'I')
      GetFileInformationByHandle  = Win32API.new('kernel32', 'GetFileInformationByHandle', [ 'L', 'P' ], 'I')
      GetShortPathName            = Win32API.new('kernel32', 'GetShortPathName', [ 'P', 'P', 'L' ], 'L')

      BHFI_pack_string            = 'LQQQLLLLLL'
    end # module Kernel32

    module Kernel32
      def self.get_file_attributes(path)

        attributes = GetFileAttributes.call(path)

        (0xffffffff == attributes) ? 0 : attributes
      end

      def self.get_short_path_name(path)

        buff = ' ' * MAX_PATH

        n = GetShortPathName.call(path, buff, buff.length)

        (0 == n) ? nil : buff[0...n]
      end

      def self.get_stat_shared(path)

        volume_id   = 0
        file_index  = 0
        num_links   = 0

        hFile = CreateFile.call(path, 0, 0, NULL, OPEN_EXISTING, 0, NULL)
        if INVALID_HANDLE_VALUE != hFile

          begin
            bhfi  = [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ]
            bhfi  = bhfi.pack(BHFI_pack_string)

            if GetFileInformationByHandle.call(hFile, bhfi)

              bhfi = bhfi.unpack(BHFI_pack_string)

              volume_id   = bhfi[4]
              file_index  = (bhfi[8] << 32) | bhfi[9]
              num_links   = bhfi[7]
            else
            end
          ensure

            CloseHandle.call(hFile)
          end
        end

        [ volume_id, file_index, num_links ]
      end
    end # module Kernel32

    # @!visibility private
    class FileStat < File::Stat # :nodoc:

      private
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

      # @!visibility private
      class ByHandleInformation # :nodoc:

        # @!visibility private
        def initialize(path) # :nodoc:

          @volume_id, @file_index, @num_links = Kernel32.get_stat_shared(path)
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

        path = path.to_str

        @path = path

        @attributes = Kernel32.get_file_attributes(path)

        super(path)

        @by_handle_information = ByHandleInformation.new(path)

        @short_path = Kernel32.get_short_path_name(path)

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

        has_attribute_? FILE_ATTRIBUTE_HIDDEN
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
      def self.stat(path) # :nodoc:

        Recls::Ximpl::FileStat.new(path)
      end
    end # class FileStat
  end # module Ximpl
end # module Recls


# ############################## end of file ############################# #


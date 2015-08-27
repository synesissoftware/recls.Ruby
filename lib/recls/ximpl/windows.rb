# ######################################################################### #
# File:        recls/ximpl/windows.rb
#
# Purpose:     Windows-specific constructs for the recls library.
#
# Created:     19th February 2014
# Updated:     27th August 2015
#
# Author:      Matthew Wilson
#
# Copyright:   <<TBD>>
#
# ######################################################################### #


require 'Win32API'

module Recls

	module Ximpl

		class FileStat < File::Stat

			private
			GetFileAttributes			=	Win32API.new('kernel32', 'GetFileAttributes', [ 'P' ], 'I')
			GetFileInformationByHandle	=	Win32API.new('kernel32', 'GetFileInformationByHandle', [ 'L', 'P' ], 'I')
			CreateFile					=	Win32API.new('kernel32', 'CreateFile', [ 'P', 'L', 'L', 'L', 'L', 'L', 'L' ], 'L')
			CloseHandle					=	Win32API.new('kernel32', 'CloseHandle', [ 'L' ], 'L')
			FILE_ATTRIBUTE_READONLY		=	0x00000001
			FILE_ATTRIBUTE_HIDDEN		=	0x00000002
			FILE_ATTRIBUTE_SYSTEM		=	0x00000004
			FILE_ATTRIBUTE_DIRECTORY	=	0x00000010
			FILE_ATTRIBUTE_ARCHIVE		=	0x00000020
			FILE_ATTRIBUTE_DEVICE		=	0x00000040
			FILE_ATTRIBUTE_NORMAL		=	0x00000080
			FILE_ATTRIBUTE_TEMPORARY	=	0x00000100
			FILE_ATTRIBUTE_COMPRESSED	=	0x00000800
			FILE_ATTRIBUTE_ENCRYPTED	=	0x00004000

			OPEN_EXISTING        		= 	0x00000003
			FILE_FLAG_OVERLAPPED 		= 	0x40000000
			NULL                 		= 	0x00000000
			INVALID_HANDLE_VALUE		=	0xFFFFFFFF


			BHFI_pack_string			=	'LQQQLLLLLL'

			class ByHandleInformation

				def initialize(path)

					@volume_id	=	0
					@file_index	=	0
					@num_links	=	0

					hFile = CreateFile.call(path, 0, 0, NULL, OPEN_EXISTING, 0, NULL);
					if INVALID_HANDLE_VALUE != hFile

						begin
							bhfi	=	[ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ]
							bhfi	=	bhfi.pack(BHFI_pack_string)

							if GetFileInformationByHandle.call(hFile, bhfi)

								bhfi		=	bhfi.unpack(BHFI_pack_string)

								@volume_id	=	bhfi[4]
								@file_index	=	(bhfi[8] << 32) | bhfi[9]
								@num_links	=	bhfi[7]
							else
							end
						ensure
							CloseHandle.call(hFile)
						end
					end
				end

				attr_reader :volume_id
				attr_reader :file_index
				attr_reader :num_links
			end

			private
			def has_attribute_? (attr)

				0 != (attr & @attributes)
			end

			private
			def initialize(path)

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
			end

			public
			attr_reader :attributes
			attr_reader :path
			attr_reader :by_handle_information

			def hidden?

				0 != (FILE_ATTRIBUTE_HIDDEN & @attributes)
			end

			# Windows-specific attributes

			def system?

				has_attribute_? FILE_ATTRIBUTE_SYSTEM
			end

			def archive?

				has_attribute_? FILE_ATTRIBUTE_ARCHIVE
			end

			def device?

				has_attribute_? FILE_ATTRIBUTE_DEVICE
			end

			def normal?

				has_attribute_? FILE_ATTRIBUTE_NORMAL
			end

			def temporary?

				has_attribute_? FILE_ATTRIBUTE_TEMPORARY
			end

			def compressed?

				has_attribute_? FILE_ATTRIBUTE_COMPRESSED
			end

			def encrypted?

				has_attribute_? FILE_ATTRIBUTE_ENCRYPTED
			end


			public
			def FileStat.stat(path)

				Recls::Ximpl::FileStat.new(path)
			end
		end
	end
end

# ############################## end of file ############################# #


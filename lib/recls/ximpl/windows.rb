
require 'Win32API'

module Recls

	module Ximpl

		class FileStat < File::Stat

			private
			GetFileAttributes = Win32API.new("kernel32", "GetFileAttributes", "P", "I")
			FILE_ATTRIBUTE_READONLY_ = 0x00000001
			FILE_ATTRIBUTE_HIDDEN_ = 0x00000002
			FILE_ATTRIBUTE_SYSTEM_ = 0x00000004
			FILE_ATTRIBUTE_DIRECTORY_ = 0x00000010

			private
			def initialize(path)

				@path = path

				attributes = GetFileAttributes.call(path)

				if 0xffffffff == attributes
					@attributes = 0
				else
					@attributes = attributes
				end

				super(path)

			end

			public
			attr_reader :attributes
			attr_reader :path

			def hidden?

				0 != (FILE_ATTRIBUTE_HIDDEN_ & @attributes)

			end # hidden?

			public
			def FileStat.stat(path)

				Recls::Ximpl::FileStat.new(path)

			end # def FileStat.stat(path)

		end

	end # module Ximpl

end # module Recls






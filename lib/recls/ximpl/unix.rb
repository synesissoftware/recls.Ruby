
require File.dirname(__FILE__) + '/util'

module Recls

	module Ximpl

		class FileStat < File::Stat

			private
			def initialize(path)

				@path = path

				super(path)

			end

			public
			attr_reader :path

			def hidden?

				basename = File.basename @path

				return false if basename.empty?
				return false if '.' == basename
				return false if '..' == basename
				return false if ?. != basename[0]

				return true

			end # hidden?

			public
			def FileStat.stat(path)

				Recls::Ximpl::FileStat::new(path)

			end # def FileStat.stat

		end

	end # module Ximpl

end # module Recls


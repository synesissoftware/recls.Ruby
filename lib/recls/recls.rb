# ######################################################################## #
# File:     recls/recls.rb
#
# Purpose:  Main source file for recls library
#
# Created:  19th July 2012
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


# The *recls* module
#
# == Significant Components
# - Recls::Entry
# - Recls::absolute_path
# - Recls::absolute_path?
# - Recls::canonicalise_path
# - Recls::derive_relative_path
# - Recls::directory?
# - Recls::exist?
# - Recls::file?
# - Recls::file_rsearch
# - Recls::file_search
# - Recls::foreach
# - Recls::stat
module Recls
end # module Recls


require 'recls/version'

require 'recls/api'
require 'recls/entry'
require 'recls/file_search'
require 'recls/foreach'
require 'recls/stat'
require 'recls/util'
require 'recls/ximpl/os'


module Recls

  # The string sequence used to separate names in paths, e.g. "/" on UNIX
  PATH_NAME_SEPARATOR = Recls::Ximpl::OS::PATH_NAME_SEPARATOR

  # The string sequence used to separate paths, e.g. ";" on Windows
  PATH_SEPARATOR = Recls::Ximpl::OS::PATH_SEPARATOR

  # Represents the "all" wildcards string for the ambient operating system
  WILDCARDS_ALL = Recls::Ximpl::OS::WILDCARDS_ALL

  # Indicates whether the operating system is a variant of Windows
  def self.windows?

    Recls::Ximpl::OS::OS_IS_WINDOWS
  end
end # module Recls


require 'recls/obsolete'


# ############################## end of file ############################# #


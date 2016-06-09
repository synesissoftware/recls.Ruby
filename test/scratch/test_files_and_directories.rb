#!/usr/bin/ruby

#############################################################################
# File:         ./test/scratch/test_files_and_directories.rb
#
# Purpose:      COMPLETE_ME
#
# Created:      09 06 2016
# Updated:      09 06 2016
#
# Author:       Matthew Wilson
#
# Copyright:    <<TBD>>
#
#############################################################################

$:.unshift File.join(File.dirname(__FILE__), '../..', 'lib')

require 'recls'

Recls::FileSearch.new(nil, nil, Recls::FILES | Recls::DIRECTORIES | Recls::RECURSIVE).each do |fe|

	path = fe.search_relative_path

	if fe.directory?

		puts path + '/'
	else

		puts path
	end
end


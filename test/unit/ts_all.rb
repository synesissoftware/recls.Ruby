#! /usr/bin/ruby
#
# executes all other tests

ThisDir = File.expand_path(File.dirname(__FILE__))
$:.unshift File.join(File.dirname(__FILE__), '../..', 'lib')


puts "executing all test cases in directory #{ThisDir}"

require ThisDir + '/' + 'tc_recls_file_search'
require ThisDir + '/' + 'tc_recls_module'
require ThisDir + '/' + 'tc_recls_util'
require ThisDir + '/' + 'tc_recls_ximpl_util'

require 'test/unit'


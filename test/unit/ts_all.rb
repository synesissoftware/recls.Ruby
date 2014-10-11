#! /usr/bin/ruby
#
# executes all other tests

$:.unshift File.join(File.dirname(__FILE__), '../..', 'lib')

ThisDir = File.dirname(__FILE__)

require 'recls'
require 'test/unit'

require ThisDir + '/' + 'tc_recls_file_search'
require ThisDir + '/' + 'tc_recls_module'
require ThisDir + '/' + 'tc_recls_util'
require ThisDir + '/' + 'tc_recls_ximpl_util'


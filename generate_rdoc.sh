#! /bin/bash

#############################################################################
# File:     generate_rdoc.sh
#
# Purpose:  Generates documentation
#
# Created:  14th April 2019
# Updated:  20th April 2024
#
#############################################################################


rm -rfd doc
rdoc \
  -x build_gem.cmd \
  -x build_gem.sh \
  -x generate_rdoc.sh \
  -x run_all_unit_tests.sh \
  -x test_all_separately.cmd \
  -x test_all_separately.sh \
  -x recls.gemspec \
  -x Rakefile \
  \
  -x doc/ \
  -x gems/ \
  -x old-gems/ \
  -x test/scratch/ \
  \
  -x obsolete.rb \
  \
  -x ts_all.rb \
  -x tc_.*\.rb \
  \
  $*


# ############################## end of file ############################# #


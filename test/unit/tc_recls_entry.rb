#! /usr/bin/env ruby
#
# test Recls entries

$:.unshift File.join(File.dirname(__FILE__), '../..', 'lib')

require 'recls'

require 'test/unit'


class Test_Recls_entry < Test::Unit::TestCase

  unless defined? assert_false
    def assert_false arg0, *args
      assert !arg0, *args
    end
  end

  def setup

    @cwd = Dir.pwd
  end

  def test_entry_does_not_mark_directory

    cwd = Recls.stat @cwd

    assert_equal @cwd, cwd.path
    assert_equal @cwd, cwd

    cwd2 = Recls.stat cwd

    assert_equal @cwd, cwd.path
    assert_equal @cwd, cwd

    assert_equal cwd.object_id, cwd2.object_id
  end

  def test_entry_does_mark_directory

    cwd = Recls.stat @cwd, Recls::MARK_DIRECTORIES

    assert_equal "#{@cwd}/", cwd.path
    assert_equal "#{@cwd}/", cwd

    cwd2 = Recls.stat cwd, Recls::MARK_DIRECTORIES

    assert_equal "#{@cwd}/", cwd.path
    assert_equal "#{@cwd}/", cwd

    assert_not_equal cwd.object_id, cwd2.object_id
  end
end


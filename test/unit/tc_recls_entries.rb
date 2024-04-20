#! /usr/bin/env ruby
#
# test Recls entries

$:.unshift File.join(File.dirname(__FILE__), '../..', 'lib')

require 'recls'

require 'test/unit'


class Test_Recls_entries < Test::Unit::TestCase

  unless defined? assert_false
    def assert_false arg0, *args
      assert !arg0, *args
    end
  end

  def test_entries_in_directory_have_unique_names

    entries         = Recls::FileSearch.new('~', Recls::WILDCARDS_ALL, Recls::FILES).to_a

    hashed_entries  = Hash[entries.each_with_index.map { |fe, index| [ fe, index] }]

    # ensure that no duplicates in hash (and hence Entry.hash and Entry.<=> work)
    assert_equal entries.size, hashed_entries.size

    entries.each_with_index do |entry, index|

      entry_a = entries[index]
      entry_b = Recls.stat(entries[index].path)

      # ensure that different entry instances representing the same path evaluate
      # equal (and hence Entry.eq? and Entry.== work)

      assert entry_a.eql? entry_a
      assert entry_a.eql? entry_b
      assert_false entry_a.eql? entry_a.path
      assert_false entry_a.eql? entry_b.path

      assert_equal entry_a, entry_a
      assert_equal entry_a, entry_b
      assert_equal entry_a, entry_a.path
      assert_equal entry_a, entry_b.path

      assert_same entry_a, entries[index]
      assert_not_same entry_a, entry_b

      assert_equal index, hashed_entries[entry_a]
      assert_equal index, hashed_entries[entry_b]
    end
  end
end


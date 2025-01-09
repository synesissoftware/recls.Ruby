#! /usr/bin/env ruby

$:.unshift File.join(File.dirname(__FILE__), '../../..', 'lib')

require 'recls'

require 'test/unit'


class Test_combine_paths < Test::Unit::TestCase

  def test_nil_nil

    if RUBY_VERSION >= '2'

      assert_raise_with_message(::ArgumentError, /must specify one or more path elements/) { Recls.combine_paths(nil, nil) }
    else

      assert_raise(::ArgumentError) { Recls.combine_paths(nil, nil) }
    end
  end

  def test_origin_nil

    strings = [

      'abc',
      'abc/def',
      'abc/def/ghi.ext',
    ]

    strings.each do |s|

      assert_equal s, Recls.combine_paths(nil, s)
    end
  end

  def test_path_nil

    strings = [

      'abc',
      'abc/def',
      'abc/def/ghi.ext',
    ]

    strings.each do |s|

      assert_equal s, Recls.combine_paths(s, nil)
    end
  end

  def test_both_relative

    assert_equal 'abc/def', Recls.combine_paths('abc', 'def')
    assert_equal 'abc/def', Recls.combine_paths('abc/', 'def')
    assert_equal 'abc/def/ghi', Recls.combine_paths('abc/def', 'ghi')
    assert_equal 'abc/def/ghi', Recls.combine_paths('abc/def/', 'ghi')
    assert_equal 'abc/def/ghi', Recls.combine_paths('abc', 'def/ghi')
    assert_equal 'abc/def/ghi', Recls.combine_paths('abc/', 'def/ghi')
    assert_equal 'abc/./def/ghi', Recls.combine_paths('abc/.', 'def/ghi')
    assert_equal 'abc/./def/ghi', Recls.combine_paths('abc/./', 'def/ghi')

    if RUBY_VERSION >= '2'

      assert_equal 'abc/./def/ghi', Recls.combine_paths('abc/.', 'def/ghi', clean_path: false)
      assert_equal 'abc/./def/ghi', Recls.combine_paths('abc/./', 'def/ghi', clean: false)
      assert_equal 'abc/def/ghi', Recls.combine_paths('abc/.', 'def/ghi', clean_path: true)
      assert_equal 'abc/def/ghi', Recls.combine_paths('abc/./', 'def/ghi', clean: true)
      assert_equal 'abc/def/ghi', Recls.combine_paths('abc/./.', 'def/ghi', clean_path: true)
      assert_equal 'abc/../def/ghi', Recls.combine_paths('abc/..', 'def/ghi')
      assert_equal 'def/ghi', Recls.combine_paths('abc/..', 'def/ghi', clean_path: true)
    end
  end

  def test_multiple_relative

    if RUBY_VERSION >= '2'

      assert_equal 'a/b/c/d/e/f/g', Recls.combine_paths('a', 'b', 'c', 'd/e/f/', 'g', clean: false)
      assert_equal 'a/b/c/d/e/f/g', Recls.combine_paths('a', 'b', 'c', 'd/e/f/', 'g', clean: true)

      assert_equal 'a/b/c/../d/e/f/g', Recls.combine_paths('a', 'b', 'c', '..', 'd/e/f/', 'g', clean: false)
      assert_equal 'a/b/d/e/f/g', Recls.combine_paths('a', 'b', 'c', '..', 'd/e/f/', 'g/', clean: true)
      assert_equal 'a/b/d/e/f/g/', Recls.combine_paths('a', 'b', 'c', '..', 'd/e/f/', 'g/', canonicalise: true)
    end
  end

  def test_various_absolute_placings

    assert_equal '/a/b/c/d/e/f/g', Recls.combine_paths('/', 'a', 'b', 'c', 'd/e', 'f/g')

    assert_equal '/b/c/d/e/f/g', Recls.combine_paths('/', 'a', '/b', 'c', 'd/e', 'f/g')

    assert_equal '/c/d/e/f/g', Recls.combine_paths('/', 'a', 'b', '/c', 'd/e', 'f/g')

    assert_equal '/d/e/f/g', Recls.combine_paths('/', 'a', 'b', 'c', '/d/e', 'f/g')

    assert_equal '/f/g', Recls.combine_paths('/', 'a', 'b', 'c', 'd/e', '/f/g')
    assert_equal '/f/g/', Recls.combine_paths('/', 'a', 'b', 'c', 'd/e', '/f/g/')

    if RUBY_VERSION >= '2'

      assert_equal '/f/g', Recls.combine_paths('/', 'a', 'b', 'c', 'd/e', '/f/g/', clean: true)
      assert_equal '/f/g/', Recls.combine_paths('/', 'a', 'b', 'c', 'd/e', '/f/g/', canonicalise: true)
    end
  end

  def test_combining_with_entries

    f_g = Recls.stat('/f/g', Recls::DETAILS_LATER)
    b = Recls.stat('b', Recls::DETAILS_LATER)

    assert_equal '/f/g', Recls.combine_paths('/', 'a', 'b', 'c', 'd/e', f_g)
    assert_equal '/f/g', Recls.combine_paths('/', 'a', b, 'c', 'd/e', f_g)
  end
end


# ############################## end of file ############################# #


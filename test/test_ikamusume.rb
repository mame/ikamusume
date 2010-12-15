# coding: utf-8

require "ikamusume"
require 'test/unit'

class TestIkamusume < Test::Unit::TestCase
  def test_s
    assert_equal(侵略![proc {|z| proc {|w| w + 2 * z } }][proc {|z| z * 3 }][5], 25)
  end

  def test_k
    assert_equal(ゲソ[42][43], 42)
  end

  def test_i
    assert_equal(イカ娘![42], 42)
  end

  def test_apply
    assert_equal(イカ娘! <= 42, 42)
    assert_equal(侵略! <= ゲソ <= ゲソ <= 42, 42)
  end
end

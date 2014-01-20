$LOAD_PATH.unshift File.dirname(__FILE__) + '/../lib'

require 'test/unit'
require 'httpauth/digest'

class DigestConversionsTest < Test::Unit::TestCase
  cases = {}
  cases[:quote_string] = {
    'word' => '"word"',
    'word word' => '"word word"'
  }
  cases[:unquote_string] = cases[:quote_string].invert
  cases[:int_to_hex] = {
    12 => '0000000c',
    1 => '00000001',
    65_535 => '0000ffff'
  }
  cases[:hex_to_int] = cases[:int_to_hex].invert
  cases[:str_to_bool] = {
    'true' => true,
    'false' => false
  }
  cases[:bool_to_str] = cases[:str_to_bool].invert
  cases[:space_quoted_string_to_list] = {
    "\"word word word\"" => %w[word word word],
    "\"word\"" => ['word']
  }
  cases[:list_to_space_quoted_string] = cases[:space_quoted_string_to_list].invert

  cases[:comma_quoted_string_to_list] = {
    "\"word,word,word\"" => %w[word word word],
    "\"word\"" => ['word']
  }
  cases[:list_to_comma_quoted_string] = cases[:comma_quoted_string_to_list].invert

  cases.each do |c, expected|
    define_method "test_#{c}" do
      expected.each do |from, to|
        assert_equal to, HTTPAuth::Digest::Conversions.send(c, from)
      end
    end
  end

  def test_unquote_string_garbage
    assert_equal 'unknown', HTTPAuth::Digest::Conversions.unquote_string('unknown')
    assert_equal '', HTTPAuth::Digest::Conversions.unquote_string('')
    assert_equal '', HTTPAuth::Digest::Conversions.unquote_string('""')
  end

  def test_str_to_bool_garbage
    assert_equal false, HTTPAuth::Digest::Conversions.str_to_bool('unknown')
  end

  def test_hex_to_int_garbage
    assert_equal 0, HTTPAuth::Digest::Conversions.hex_to_int('unknown')
  end

  def test_quoted_string_to_list_garbage
    assert_equal ['unknown'], HTTPAuth::Digest::Conversions.space_quoted_string_to_list('unknown')
    assert_equal ['unknown'], HTTPAuth::Digest::Conversions.comma_quoted_string_to_list('unknown')
  end
end

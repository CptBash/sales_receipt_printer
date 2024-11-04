# test/receipt_test.rb
require 'minitest/autorun'
require_relative '../lib/receipt/item'

class ItemTest < Minitest::Test
  # happy path
  def test_parse_item_string
    item_string = "9 books at 21.99"
    expected_output = {volume: 9, item: "books", price: 21.99}
    assert_equal expected_output, Item.parse_item_string(item_string)
  end

  def test_is_taxable
    item = "books"
    assert_equal false, Item.is_taxable(item)

    item = "fooBar"
    assert_equal true, Item.is_taxable(item)
  end

  # TODO: add edge case/sad path tests as item becomes more complex
end
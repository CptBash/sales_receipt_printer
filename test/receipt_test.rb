# test/receipt_test.rb
require 'minitest/autorun'
require_relative '../lib/receipt/item'
require_relative '../lib/receipt/receipt'

class ReceiptTest < Minitest::Test
  def setup
    @items = ["1 imported bottle of perfume at 27.99", "1 bottle of perfume at 18.99", "1 packet of headache pills at 9.75", "3 imported boxes of chocolates at 11.25"]
  end

  def test_build_receipt
    expected_receipt = <<~OUTPUT
        1 imported bottle of perfume: $32.19
        1 bottle of perfume: $20.89
        1 packet of headache pills: $10.73
        3 imported boxes of chocolates: $35.44
        Sales Taxes: $8.77
        Total: $99.25
      OUTPUT
    assert_equal expected_receipt, Receipt.create_receipt(@items)
  end

  def test_add_items_to_receipt
    expected_receipt = <<~OUTPUT
        1 imported bottle of perfume: $32.19
        1 bottle of perfume: $20.89
        1 packet of headache pills: $10.73
        3 imported boxes of chocolates: $35.44
        Sales Taxes: $8.77
        Total: $99.25
      OUTPUT
    assert_equal expected_receipt, Receipt.add_items_to_receipt("", @items)
  end

  def test_calculate_tax
    # normal rate
    price = 21.99
    tax_rate = 0.1
    assert_equal 2.20, Receipt.calculate_tax(price, tax_rate)

    # imported rate
    price = 9000
    tax_rate = 0.05
    assert_equal 450.00, Receipt.calculate_tax(price, tax_rate)
  end
end
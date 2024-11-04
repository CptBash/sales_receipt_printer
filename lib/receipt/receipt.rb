require_relative "item"
require 'bigdecimal'
require 'bigdecimal/util'

# This module is responsible for generating the receipt for the user input
# Uses Item module to parse item string and determine if item is taxable
# calculates tax and total price, and returns a receipt string
module Receipt
  def self.create_receipt(items)
    # TODO: style the receipt string, could include store name, date, etc.
    receipt = ""
    receipt << add_items_to_receipt(receipt, items)
    receipt
  end

  def self.add_items_to_receipt(receipt, items)
    sales_tax = 0
    total = 0
    items.each do |item|
      # parse item string into hash
      item_hash = Item.parse_item_string(item)
      # calculate tax based on item type and imported status
      # tax rate is 10% for taxable items and 5% for imported items
      tax_rate = set_tax_rate(item_hash[:item])
      tax = calculate_tax(item_hash[:price], tax_rate)
      sales_tax += tax
      line_total = calculate_line_total(item_hash[:volume], item_hash[:price], tax)
      total += line_total
      receipt += "#{item_hash[:volume]} #{item_hash[:item]}: $#{line_total}\n"
    end
    receipt += "Sales Taxes: $#{sales_tax}\n"
    receipt += "Total: $#{total}\n"
    receipt
  end

  def self.calculate_tax(price, tax_rate)
    (price * tax_rate).round(2)
  end

  def self.calculate_line_total(volume, price, tax)
    (BigDecimal(volume.to_s) * BigDecimal(price.to_s) + BigDecimal(tax.to_s)).round(2).to_f
  end

  def self.set_tax_rate(item)
    if Item.is_taxable(item) && item.include?("imported")
      0.15
    elsif Item.is_taxable(item)
      0.10
    elsif item.include?("imported")
      0.05
    else
      0
    end
  end
end
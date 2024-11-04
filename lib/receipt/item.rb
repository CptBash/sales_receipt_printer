# Item class is responsible for parsing item string and returning a hash
# with volume, item, and price. We also determine if the item is taxable based on item name
module Item
  # exempted_items is a list of items that are not taxable
  # TODO: move to a config file
  @exempted_items = ["books", "food", "medical products"].freeze

  # parse_item_string takes item_string including volume, 
  # item, and price and returns a hash with volume, item, and price
  def self.parse_item_string(item_string)
    # split string into array after each space for better manipulation
    item_string = item_string.split(" ")
    volume = item_string[0].to_i
    price = item_string[-1].to_f
    item = item_string[1..-3].join(" ")
    {volume: volume, item: item, price: price}
  end

  # check for exempted items against item name
  def self.is_taxable(item)
    !@exempted_items.any? { |exempted_item| item.include?(exempted_item) }
  end
  
end
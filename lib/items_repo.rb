require 'CSV'
require 'time'
require 'bigdecimal'
require 'bigdecimal/util'
require_relative './sales_engine'
require_relative './module'
require_relative './items'


class ItemsRepo
  include Methods
  attr_reader :collections

  def populate_collection
    items = Hash.new{|h, k| h[k] = [] }
    CSV.foreach(@data, headers: true, header_converters: :symbol) do |data|
      items[data[:id]] = Item.new(data, self)
    end
      items
  end

  def find_all_by_price (price)
    all.find_all do |value| 
      value.unit_price == price
    end
  end

  def group_by_merchant_id
    all.group_by{|value| value.merchant_id}
  end

  def find_all_with_description(description)
  	all.find_all do |item|
      item.description.downcase.include?(description.downcase)
    end
  end

  def find_all_by_price_in_range(range)
  	all.find_all do |item|
  		range.include?(item.unit_price)
  	end
  end

  def create(attributes)
    @collections[attributes[:id]] = Item.new({
      :id          => new_id,
      :name        => attributes[:name],
      :description => attributes[:description],
      :unit_price  => attributes[:unit_price],
      :merchant_id => attributes[:merchant_id],
      :created_at  => attributes[:created_at],
      :updated_at  => attributes[:updated_at]},
      self)
  end

  def delete(id)
    @collections.delete_if do |key,value|
      value.id == id
    end
  end

end

require 'CSV'
require_relative './items'
require 'time'
require 'bigdecimal'
require 'bigdecimal/util'
require_relative './sales_engine'
require_relative './module'

class ItemsRepo
  include Methods
  attr_reader :collections

  def initialize(data, engine)
    @data = data
    @collections = populate_collection
    @engine = engine
  end

  def populate_collection
    items = Hash.new{|h, k| h[k] = [] }
    CSV.foreach(@data, headers: true, header_converters: :symbol) do |data|
      items[data[:id]] = Item.new(data, self)
    end
    items
  end

  def find_all_by_price (price)
    all.values.find_all{|value| value.unit_price == price}
  end

  def group_by_merchant_id
    all.values.group_by{|value| value.merchant_id}
  end

  def find_all_with_description(description)
  	desc_str = description.split

  	all.values.find_all do |item|
  		item if desc_str.any? {|string|  item.description.include? string.downcase}
  	end
  end

  def find_all_by_price_in_range(range)
  	all.values.find_all do |item|
  		range.include?(item.unit_price_to_dollars)
  	end
  end

  def create(attributes)
    @collections[attributes[:id]] = Item.new({
            :id => new_id,
          :name => attributes[:name].downcase,
   :description => attributes[:description].downcase,
    :unit_price => attributes[:unit_price],
   :merchant_id => attributes[:merchant_id],
    :created_at => attributes[:created_at],
    :updated_at => attributes[:updated_at]},self)
  end

end

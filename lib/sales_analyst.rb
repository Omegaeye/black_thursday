require 'CSV'
require_relative './sales_engine'
require_relative './mathable'

class SalesAnalyst
  include Mathable

  def initialize(engine)
    @engine = engine
  end

  def total_items_across_all_merchants
    @engine.items_per_merchant.values.flatten.count.to_f
  end

  def total_merchants
    @engine.items_per_merchant.keys.count
  end

  def average_items_per_merchant
    average(total_items_across_all_merchants, total_merchants)
  end

  def all_items_by_merchant
    @engine.items_per_merchant.map do |merchant, items|
      items.count
    end
  end

  def item_stand_deviation
    final_std_dev(all_items_by_merchant, average_items_per_merchant)
  end

  def merchants_with_high_item_count
    collector_array = []
    items_per_merchant.each do |item_id, items|
      if items.count.to_f > (standard_deviation + average_items_per_merchant)
        @engine.merchants.collections.each do |merchant_id, total_merchants|
          if total_merchants.id == item_id
            collector_array << total_merchants.name
          end
        end
      end
    end
  end

  def items_to_be_averaged(merchant_number)
    collector = []
    items_per_merchant.each do |merchant_id, items|
      if merchant_id == merchant_number
        collector << items
      end
    end
    collector.flatten
  end

  def sum_item_price_for_merchant(merchant_number)
    total_price = 0
    items_to_be_averaged(merchant_number).each do |item|
      total_price += item.unit_price
    end
    total_price.to_i
  end

  def average_item_price_for_merchant(merchant_id)
    sum_item_price_for_merchant(merchant_id) / items_to_be_averaged(merchant_id).count
  end

  def merchant_id_collection
    items_per_merchant.keys
  end

  def average_item_prices_collection
    merchant_id_collection.map do |merchant_id|
      average_item_price_for_merchant(merchant_id)
    end
  end

  def sum_average_prices_collections
    average_item_prices_collection.sum
  end

  def average_average_price_per_merchant
    sum_average_prices_collections / merchant_id_collection.count
  end

  def difference_of_item_prices_and_total_average_item_prices
    average_item_prices_collection.map do |average|
      average - average_average_price_per_merchant
    end
  end

  def squares_of_average_prices_differences
    difference_of_item_prices_and_total_average_item_prices.map do |number|
      number ** 2
    end
  end

  def sum_of_square_item_price_differences
    squares_of_average_prices_differences.sum
  end

  def std_dev_item_price_variance
    merchant_id_collection.count - 1
  end

  def item_price_sum_and_variance_quotient
    sum_of_square_item_price_differences / std_dev_item_price_variance
  end

  def item_price_standard_deviation
    (item_price_sum_and_variance_quotient ** 0.5).round(2)
  end

  def double_item_price_standard_deviation
    item_price_standard_deviation * 2
  end

  def golden_items_critera
    double_item_price_standard_deviation + average_average_price_per_merchant
  end

  def item_collection
    items_per_merchant.values.flatten
  end

  def golden_items
    item_collection.find_all do |item|
      item.unit_price > golden_items_critera
    end
  end
end

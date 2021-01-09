require 'CSV'
require './test/test_helper'

class SalesAnalystTest < Minitest::Test

  def setup
    data_1 = {
            :items     => "./dummy_data/dummy_items.csv",
            :merchants => "./dummy_data/dummy_merchants_analyst.csv"
            #Add CSV dummy files
            }
    sales_engine_1 = SalesEngine.new(data_1)
    @sales_analyst = sales_engine_1.sales_analyst
  end

  def test_it_exists
    assert_instance_of SalesAnalyst, @sales_analyst
  end

  def test_average_items_per_merchant
    assert_equal 4, @sales_analyst.total_merchants
    assert_equal ["1", "2", "3", "4"], @sales_analyst.items_per_merchant.keys
    assert_equal 1.25, @sales_analyst.average_items_per_merchant
  end

  def test_it_can_calculate_standard_deviation
    assert_equal [1, 2, 1, 1], @sales_analyst.all_items_by_merchant
    assert_equal [-0.25, 0.75, -0.25, -0.25], @sales_analyst.difference_of_item_and_average_items
    assert_equal [0.0625, 0.5625, 0.0625, 0.0625], @sales_analyst.squares_of_differences
    assert_equal 0.75, @sales_analyst.sum_of_square_differences
    assert_equal 3, @sales_analyst.std_dev_variance
    assert_equal 0.25, @sales_analyst.sum_and_variance_quotient
    assert_equal 0.50, @sales_analyst.standard_deviation
  end

  def test_merchants_with_high_item_count
    assert_equal ["Keckenbauer"], @sales_analyst.merchants_with_high_item_count
  end

  def test_average_items_price_per_merchant
    assert_equal 2, @sales_analyst.items_to_be_averaged("2").count
    assert_equal 201000, @sales_analyst.sum_item_price_for_merchant("2")
    assert_equal 100500, @sales_analyst.average_item_price_for_merchant("2")
  end

  def test_average_average_price_per_merchant
    assert_equal 4, @sales_analyst.merchant_id_collection.count
    assert_equal [200, 100500, 4500, 46000], @sales_analyst.average_item_prices_collection
    assert_equal 151200, @sales_analyst.sum_average_prices_collections
    assert_equal 37800, @sales_analyst.average_average_price_per_merchant
  end

  def test_golden_items
    assert_equal [-37600, 62700, -33300, 8200], @sales_analyst.difference_of_item_prices_and_total_average_item_prices
    assert_equal [0.141376e10, 0.393129e10, 0.110889e10, 0.6724e8], @sales_analyst.squares_of_average_prices_differences
    assert_equal 6521180000, @sales_analyst.sum_of_square_item_price_differences
    assert_equal 3, @sales_analyst.std_dev_item_price_variance
    assert_equal 2173726666, @sales_analyst.item_price_sum_and_variance_quotient
    assert_equal 46623.24, @sales_analyst.item_price_standard_deviation
    assert_equal 93246.48, @sales_analyst.double_item_price_standard_deviation
    assert_equal 131046.48, @sales_analyst.golden_items_critera
    assert_equal 5, @sales_analyst.item_collection.count
    assert_equal 1, @sales_analyst.golden_items.count
  end


end

require 'CSV'
require_relative './test_helper'


class SalesEngineTest < Minitest::Test
  def setup
    data = {
            :items     => "./dummy_data/dummy_items.csv",
            :merchants => "./dummy_data/dummy_merchants.csv"
            #Add CSV dummy files
            }
    @engine = SalesEngine.new(data)
  end

  def test_it_exists
    assert_instance_of SalesEngine, @engine
  end

  def test_items_per_merchant
    assert_equal 4, @engine.items_per_merchant.count
    assert_equal 4, @engine.total_merchants
    assert_equal 5, @engine.merchants_names.keys.count
  end
end

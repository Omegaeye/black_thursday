require 'CSV'
require_relative './test_helper'

class SalesAnalystTest < Minitest::Test

  def setup
    data_1 = {
            :items     => "./dummy_data/dummy_items.csv",
            :merchants => "./dummy_data/dummy_merchants_analyst.csv",
            :invoices => "./dummy_data/dummy_invoice.csv",
            :transactions => "./dummy_data/dummy_transactions.csv",
            :invoice_items => "./dummy_data/dummy_invoice_item.csv",
            :customers => "./dummy_data/dummy_customer.csv"
            }
    @sales_engine_1 = SalesEngine.new(data_1)
    @sales_analyst = @sales_engine_1.analyst
  end

  def test_it_exists
    assert_instance_of SalesAnalyst, @sales_analyst
  end

  def test_average_items_per_merchant
    assert_equal 5, @sales_analyst.count_of_total_items_across_all_merchants
    assert_equal [1, 2, 3, 4], @sales_engine_1.items_per_merchant.keys
    assert_equal 1.25, @sales_analyst.average_items_per_merchant
    assert_equal [1, 2, 1, 1], @sales_analyst.count_of_all_items_by_merchant
  end

  def test_average_invoices_per_merchant
    expected = [3, 3, 2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]
    assert_equal expected, @sales_analyst.group_invoices_by_merchant_id_values
    assert_equal 20.0, @sales_analyst.group_invoices_sum
    assert_equal 15, @sales_analyst.group_total_invoice_merchant_sum
    assert_equal 1.33, @sales_analyst.average_invoices_per_merchant
  end

  def test_average_invoices_per_merchant_standard_deviation

    assert_equal 0.72, @sales_analyst.average_invoices_per_merchant_standard_deviation
  end

  def test_top_merchants_by_invoice_count
    assert_equal 2, @sales_analyst.top_merchants_by_invoice_count.count
  end

  def test_bottom_merchants_by_invoice_count
    assert_equal [], @sales_analyst.bottom_merchants_by_invoice_count
  end

  def test_it_can_calculate_standard_deviation
    assert_equal [-0.25, 0.75, -0.25, -0.25], @sales_analyst.difference_of_each_x_and_y([1, 2, 1, 1], 1.25)
    assert_equal [0.0625, 0.5625, 0.0625, 0.0625], @sales_analyst.squares_of_differences([-0.25, 0.75, -0.25, -0.25])
    assert_equal 0.75, @sales_analyst.squares_of_differences([-0.25, 0.75, -0.25, -0.25]).sum
    assert_equal 3, @sales_analyst.std_dev_variance([1, 2, 1, 1])
    assert_equal 0.25, @sales_analyst.sum_and_variance_quotient(0.75, 3)
    assert_equal 0.50, @sales_analyst.average_items_per_merchant_standard_deviation
  end

  def test_merchants_with_high_item_count
    assert_equal 1.75, @sales_analyst.sum_of(0.50, 1.25)
    assert_equal 1.75, @sales_analyst.one_std_dev_above_avg_std_dev_items_per_merchant
    assert_equal "Keckenbauer", @sales_analyst.merchants_with_high_item_count[0].name
  end

  def test_golden_items
    assert_equal 1, @sales_analyst.golden_items.count
  end

  def test_invoice_paid_in_full
    assert_equal true, @sales_analyst.invoice_paid_in_full?(1)
    assert_equal false, @sales_analyst.invoice_paid_in_full?(11)
  end

  def test_invoice_total_by_invoice_id
    assert_equal 0.348956e4, @sales_analyst.invoice_total(1)
  end
end

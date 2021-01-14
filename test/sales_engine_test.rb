require 'CSV'
require_relative './test_helper'


class SalesEngineTest < Minitest::Test
  def setup
    data = {
      :items     => "./dummy_data/dummy_items.csv",
      :merchants => "./dummy_data/dummy_merchants_analyst.csv",
      :invoices => "./dummy_data/dummy_invoice.csv",
      :transactions => "./dummy_data/dummy_transactions.csv",
      :invoice_items => "./dummy_data/dummy_invoice_item.csv",
      :customers => "./dummy_data/dummy_customer.csv"
      }
    @engine = SalesEngine.new(data)
  end

  def test_it_exists
    assert_instance_of SalesEngine, @engine
  end

  def test_group_invoices_by_merchant_id
    assert_instance_of Hash, @sales_analyst.group_invoices_by_merchant_id
    assert_equal true, @sales_analyst.group_invoices_by_merchant_id.keys.all?{ |key| key.is_a? Integer}
  end

  def test_group_invoices_by_merchant_id
    assert_instance_of Hash, @engine.group_invoices_by_merchant_id
    assert_equal true, @engine.group_invoices_by_merchant_id.keys.all?{ |key| key.is_a? Integer}
  end

  def test_it_can_find_successful_transactions
    assert_equal 9, @engine.transactions_by_result(:success).count
  end

  def test_invoice_by_invoice_id
    assert_equal 4, @engine.invoice_by_invoice_id(1).count
  end

  def test_invoice_by_date
    date = Time.parse("2012-03-27")
    assert_equal 5, @engine.finding_invoices_by_day(date).count
    assert_equal 5, @engine.total_invoice_by_date("2012-03-27").count
  end

end
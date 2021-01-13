require_relative './test_helper'

class InvoiceItemRepoTest < Minitest::Test

  def setup
    @engine = mock
    @dummy_repo = InvoiceItemRepo.new("./dummy_data/dummy_invoice_item.csv", @engine)
  end

  def test_it_is
    assert_instance_of InvoiceItemRepo, @dummy_repo
  end

  def test_it_has_attributes
    assert_instance_of Hash , @dummy_repo.collections
  end

  def test_find_by_id
    actual = @dummy_repo.find_by_id(1)
    assert_equal 123, actual.item_id
  end

  def test_find_all_by_item_id
    actual = @dummy_repo.find_all_by_item_id(123)
    assert_equal 5, actual[0].quantity
  end

  def test_find_all_by_invoice_id
    actual = @dummy_repo.find_all_by_invoice_id(2)
    assert_equal 1, actual.length
  end

  def test_it_can_create_new_item
    data ={
      :id => 6,
      :item_id => 11,
      :invoice_id => 6,
      :quantity => 4,
      :unit_price => 9999,
      :created_at => "2125-09-22 09:34:06 UTC",
      :updated_at => "2034-09-04 21:35:10 UTC"
      }
    @dummy_repo.create(data)
    actual = @dummy_repo.find_by_id(6)
    assert_equal 6, actual.id
  end

  def test_update
    data ={
      :id => 6,
      :item_id => 11,
      :invoice_id => 6,
      :quantity => 4,
      :unit_price => 9999,
      :created_at => "2125-09-22 09:34:06 UTC",
      :updated_at => "2034-09-04 21:35:10 UTC"
      }
    @dummy_repo.create(data)
    actual = @dummy_repo.find_all_by_item_id(11)
    assert_equal 4, actual[0].quantity
    actual = @dummy_repo.find_by_id(6)
    assert_equal 11, actual.item_id

    @dummy_repo.update( 6, {id: 6, quantity: 355, unit_price: 1000})

    actual = @dummy_repo.find_by_id(6)
    assert_equal 355, actual.quantity
  end

  def test_delete
    data = {
      :id => 6,
      :item_id => 11,
      :invoice_id => 6,
      :quantity => 4,
      :unit_price => 9999,
      :created_at => "2125-09-22 09:34:06 UTC",
      :updated_at => "2034-09-04 21:35:10 UTC"
      }
    @dummy_repo.create(data)
    actual = @dummy_repo.find_by_id(6)
    assert_equal 11, actual.item_id
    @dummy_repo.delete(6)

    assert_nil nil, @dummy_repo.find_by_id(11)
  end

end

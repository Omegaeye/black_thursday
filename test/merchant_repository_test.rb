require 'csv'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/merchant'
require './lib/merchant_repository'

class MerchantRepositoryTest < Minitest::Test

  def setup
    @dummy_path = "./dummy_data/dummy_merchants.csv"
  end

  def test_it_exists
    merchant_repo = MerchantRepository.new(@dummy_path)
    assert_instance_of MerchantRepository, merchant_repo
  end

  def test_it_has_attributes
    merchant_repo = MerchantRepository.new(@dummy_path)
    assert_equal 5, merchant_repo.all.count
    assert_equal @dummy_path, merchant_repo.data
  end

  def test_populate_repo
    merchant_repo = MerchantRepository.new(@dummy_path)
    merchant_repo.populate_repo
    assert_instance_of Merchant, merchant_repo.all.sample
  end

  def test_max_id
    merchant_repo = MerchantRepository.new(@dummy_path)
    assert_equal "12334141", merchant_repo.max_id.id
  end

  def test_new_id
    merchant_repo = MerchantRepository.new(@dummy_path)
    assert_equal 12334142, merchant_repo.new_id
  end

  def test_create
    merchant_repo = MerchantRepository.new(@dummy_path)
    actual = merchant_repo.create("Hank")
    assert_equal merchant_repo.all[-2].id.to_i + 1, actual[-1].id.to_i
    assert_equal "Hank", merchant_repo.all[-1].name
  end

  def test_find_by_id
    merchant_repo = MerchantRepository.new(@dummy_path)
    assert_equal "jejum", merchant_repo.find_by_id(12334141).name
  end

  # def test_all
  #   merchant_repo = MerchantRepository.new("./data/merchants.csv")
  #   merchant_repo.all = data.map do |row|
  #     Merchant.new({:id => row[:id], :name => row[:name]})
  #   end
  #   assert_instance_of Merchant, merchant_repo.all.sample
  # end

  # def test_it_has_attributes
  #   merchant_repo = MerchantRepository.new
  #   assert_equal [], merchant_repo.all
  # end

  # def test_it_can_create_new_merchant
  #   merchant_repo = MerchantRepository.new
  #   merchant_repo.create(:id, :name)
  #   assert_instance_of Merchant, merchant_repo.all.sample
  # end

  # def test_find_by_id
  #   merchant_repo = MerchantRepository.new
  #   merchant_repo.create(:id, :name)
  #   assert_equal 12334144, merchant_repo.find_by_id(12334144)[:id]
  # end
end

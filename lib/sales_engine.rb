require_relative './items_repo'
require_relative './merchant_repository'

class SalesEngine
  attr_reader :items,
              :merchants,
              :sales_analyst

  def self.from_csv(data)
    new(data)
  end

  def initialize(data)
    @items = ItemsRepo.new(data[:items], self)
    @merchants = MerchantRepository.new(data[:merchants], self)
    @sales_analyst = SalesAnalyst.new(self)
    @invoice = InvoiceItemRepo.new(data[:items], self)
    @customer = CustomerRepo.new(data[:items], self)
    @transaction = TransactionRepo.new(data[:items], self)
  end

  def items_per_merchant
    @items.group_by_merchant_id
  end

  def total_merchants
    items_per_merchant.keys.count
  end

  def merchants_names
    @merchants.collections.map do |id, merchant|
      [id, merchant.name]
    end
  end

end

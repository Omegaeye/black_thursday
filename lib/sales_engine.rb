require_relative './items_repo'
require_relative './merchant_repository'
require_relative './analyst'
require_relative './invoice_repo'
require_relative './transaction_repo'
require_relative './invoice_items_repo'
require_relative './customer_repo'

class SalesEngine
  attr_reader :items,
              :merchants,
              :sales_analyst
              :invoices,
              :transactions,
              :invoice_items,
              :customers

  def self.from_csv(data)
    new(data)
  end

  def initialize(data)
    @items = ItemsRepo.new(data[:items], self)
    @merchants = MerchantRepository.new(data[:merchants], self)
    @sales_analyst = SalesAnalyst.new(self)
    @invoices = InvoiceRepo.new(data[:invoices], self)
    @transactions = TransactionRepo.new(data[:transactions], self)
    @invoice_items = InvoiceItemRepo.new(data[:invoice_items], self)
    @customers = CustomerRepo.new(data[:customers], self)
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

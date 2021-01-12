require_relative './items_repo'
require_relative './merchant_repository'
require_relative './sales_analyst'
require_relative './invoice_repo'
require_relative './transaction_repo'
require_relative './invoice_items_repo'
require_relative './customer_repo'

class SalesEngine
  attr_reader :items,
              :merchants,
              :analyst,
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
    @analyst = SalesAnalyst.new(self)
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

  def find_all_items_by_merchant_id(merchant_id)
    @items.all.find_all{|item|item.merchant_id == merchant_id}
  end


  def total_of_all_invoices
    @invoices.all_invoices_by_day.values
  end

  def finding_invoices_by_day(day)
    total_of_all_invoices.flatten.find_all{|key| key.created_at.strftime("%A") == day}
  end

  def group_invoices_by_merchant_id
    @invoices.collections.group_by do |key, invoice|
      invoice.merchant_id
    end
  end

  def all_items_by_unit_price
    @items.all.group_by{|item|item.unit_price}
  end
end

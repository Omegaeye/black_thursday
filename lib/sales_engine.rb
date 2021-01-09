require_relative './items_repo'
require_relative './merchant_repository'
require_relative './analyst'
require_relative './invoice_repo'


class SalesEngine
  attr_reader :items,
              :merchants,
              :analyst,
              :invoices

  def self.from_csv(data)
    new(data)
  end

  def initialize(data)
    @items = ItemsRepo.new(data[:items], self)
    @merchants = MerchantRepository.new(data[:merchants], self)
    @analyst = Analyst.new(self)
    @invoices = InvoiceRepo.new(data[:invoices], self)
  end
end

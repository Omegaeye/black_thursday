require 'CSV'
require 'time'
require 'bigdecimal'
require 'bigdecimal/util'
require_relative './sales_engine'
require_relative './central_repo'
require_relative './module'
require_relative './invoice'


class InvoiceRepo < CentralRepo
  attr_reader :collections,
              :data

  def initialize(data, engine)
    super
  end

  def initialize(data, engine)
    @data = data
    @collections = populate_collection
    @engine = engine
  end

  def populate_collection
    invoices = Hash.new{|h, k| h[k] = [] }
    CSV.foreach(@data, headers: true, header_converters: :symbol) do |data|
      invoices[data[:id]] = Invoice.new(data, self)
    end
      invoices
  end

  def find_all_by_status(status)
    all.find_all do |value|
      value.status == status
    end
  end

  def all_invoices_by_day
    all.group_by do |invoice|
      invoice.created_at.strftime("%A")
    end
  end

  def find_all_by_date(date)
    @collections.select do |key, value|
      value.created_at.strftime("%F") == date.strftime("%F")
    end
  end

  def select_invoices_by_merchant_id(merchant_id)
    @collections.select do |key,value|
      value.merchant_id
    end
  end

  def select_failed_merchants(invoice_id)
    @collections.find_all do |key,value|
      value.id == invoice_id
    end
  end


  def create(attributes)
    @collections[attributes[:id]] = Invoice.new({
      :id          => new_id,
      :customer_id => attributes[:customer_id],
      :merchant_id => attributes[:merchant_id],
      :status      => attributes[:status],
      :created_at  => attributes[:created_at],
      :updated_at  => attributes[:updated_at]},
      self)
  end

end

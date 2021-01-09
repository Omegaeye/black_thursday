require 'CSV'
require 'time'
require 'bigdecimal'
require 'bigdecimal/util'
require './lib/module'
require './lib/invoice'

class InvoiceRepo
  include Methods
  attr_reader :collections

  def initialize(data, engine)
    @data = data
    @collections = populate_collection
    @engine = engine
  end

  def populate_collection
    items = Hash.new{|h, k| h[k] = [] }
      CSV.foreach(@data, headers: true, header_converters: :symbol) do |data|
      items[data[:id]] = Invoice.new(data, self)
      end
      items
    end

    def create(attributes)
      @collections[attributes[:id]] = Invoice.new({
      :id          => new_id,
      :customer_id => attributes[:customer_id],
      :merchant_id => attributes[:merchant_id],
      :status      => attributes[:status],
      :created_at  => attributes[:created_at],
      :updated_at  => attributes[:updated_at]}, self)
    end
end

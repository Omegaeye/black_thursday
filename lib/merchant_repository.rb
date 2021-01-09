require_relative './sales_engine'
require_relative './merchant'
require_relative './module'
require 'time'

class MerchantRepository
  include Methods
  attr_reader :collections

  def populate_collection
    items = Hash.new{|h, k| h[k] = [] }
    CSV.foreach(@data, headers: true, header_converters: :symbol) do |data|
      items[data[:id]] = Merchant.new(data, self)
    end
    items
  end

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end

  def create(attributes)
      @collections[attributes[:id]] =
      Merchant.new({
                :id => new_id,
              :name => attributes[:name],
        :created_at => Time.now,
        :updated_at => Time.now}, self)
  end
end

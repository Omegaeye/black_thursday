require_relative './sales_engine'
require_relative './merchant'
require_relative './module'
require 'time'

class MerchantRepository
  include Methods
  attr_reader :collections

  def populate_collection
    merchants = Hash.new
    CSV.foreach(@data, headers: true, header_converters: :symbol) do |data|
      merchants[data[:id]] = Merchant.new(data, self)
    end
      merchants
  end

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end

  def find_all_by_name(search_string)
    all.find_all do |value|
      value.name.downcase.include?(search_string.downcase)
    end
  end

  def create(attributes)
    @collections[attributes[:id]] = Merchant.new({
      :id         => new_id,
      :name       => attributes[:name],
      :created_at => Time.now,
      :updated_at => Time.now}, 
      self)
  end
  def delete(id)
    @collections.delete_if do |key,value|
      value.id == id
    end
  end
end

require 'CSV'
require 'time'
require_relative './module'
require_relative './customer'
require_relative './sales_engine'

class CustomerRepo
  include Methods
  attr_reader :collections,
              :data

  def populate_collection
    customers = Hash.new{|h, k| h[k] = [] }
    CSV.foreach(@data, headers: true, header_converters: :symbol) do |data|
      customers[data[:id]] = Customer.new(data, self)
    end
      customers
  end

  def find_all_by_first_name(first_name)
    all.find_all do |name|
      name.first_name.downcase.include?(first_name.downcase)
    end
  end

  def find_all_by_last_name(last_name)
    all.find_all do |l_name|
      l_name.last_name.downcase.include?(last_name.downcase)
    end
  end

  def create(attributes)
    @collections[attributes[:id]] = Customer.new({
      :id         => new_id,
      :first_name => attributes[:first_name],
      :last_name  => attributes[:last_name],
      :created_at => attributes[:created_at],
      :updated_at => attributes[:updated_at]},
      self)
  end
end

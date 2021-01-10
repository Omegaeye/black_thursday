require 'CSV'
require 'time'
require 'bigdecimal'
require 'bigdecimal/util'
require_relative './module'
require_relative './transaction'
require_relative './sales_engine'
require_relative './central_repo'

class TransactionRepo < CentralRepo
  attr_reader :collections

  def initialize(data, engine)
    super
  end


  def populate_collection
    transaction = Hash.new{|h, k| h[k] = [] }
    CSV.foreach(@data, headers: true, header_converters: :symbol) do |data|
      transaction[data[:id]] = Transaction.new(data, self)
    end
      transaction
  end

  def find_all_by_credit_card_number(credit_card_number)
    all.find_all do |value|
      value.credit_card_number == credit_card_number
    end
  end

  def find_all_by_result (result)
    all.find_all do |value|
      value.result == result
    end
  end

  def create(attributes)
    @collections[attributes[:id]] = Transaction.new({
      :id                           => new_id,
      :invoice_id                   => attributes[:invoice_id ],
      :credit_card_number           =>   attributes[:credit_card_number],
      :credit_card_expiration_date  => attributes[:credit_card_expiration_date],
      :result                       => attributes[:result],
      :created_at                   => attributes[:created_at],
      :updated_at                   => attributes[:updated_at]}, self)
  end
end

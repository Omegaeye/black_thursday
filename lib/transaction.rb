require 'time'
require 'bigdecimal/util'
require 'bigdecimal'
class Transaction

  attr_accessor :credit_card_expiration_date
  attr_reader :id,
              :invoice_id,
              :credit_card_number,
              :result,
              :created_at,
              :updated_at

  def initialize (data, repository)
    @id                  = data[:id].to_i
    @invoice_id          = data[:invoice_id].to_i
    @credit_card_number  = data[:credit_card_number]
    @credit_card_expiration_date = data[:credit_card_expiration_date]
    @result              = data[:result].intern
    @created_at          = Time.parse(data[:created_at].to_s)
    @updated_at          = Time.parse(data[:updated_at].to_s)
    @repository          = repository
  end

  def unit_price_to_dollars
    @unit_price.to_f
  end

  def update_attributes (new_attributes)
    @credit_card_number  = new_attributes[:credit_card_number]
    @credit_card_expiration_date = new_attributes[:credit_card_expiration_date]
    @result = new_attributes[:result]
  end
end

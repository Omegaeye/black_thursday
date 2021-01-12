require 'time'
require 'bigdecimal/util'
require 'bigdecimal'
class Item

  attr_accessor :name,
                :description,
                :unit_price,
                :updated_at
  attr_reader   :id,
                :merchant_id,
                :created_at


  def initialize (data, repository)
    @id          = data[:id].to_i
    @name        = data[:name]
    @description = data[:description]
    @unit_price  = (BigDecimal(data[:unit_price].to_i) / 100)
    @merchant_id = data[:merchant_id].to_i
    @created_at  = Time.parse(data[:created_at].to_s)
    @updated_at  = Time.parse(data[:updated_at].to_s)
    #@repository  = repository
  end

  def unit_price_to_dollars
    @unit_price.to_f
  end

  # def update_name (name)
  #   @name = name
  # end


  def update_attributes (new_attributes )
    @name        = (new_attributes[:name]) unless new_attributes[:name] == nil
    @description = new_attributes[:description] unless new_attributes[:description] == nil
    @unit_price  = new_attributes[:unit_price] unless new_attributes[:unit_price] == nil
    @updated_at  = new_attributes[:updated_at] = Time.now
  end

end

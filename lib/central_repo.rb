require 'time'
require 'bigdecimal/util'
require 'bigdecimal'
class CentralRepo

  def initialize(data, engine)
    @data        = data
    @collections = populate_collection
    @engine      = engine
  end

  def all
    @collections.values
  end

  def find_by_id(id)
    all.find do |value|
      value.id == id
    end
  end

  def find_by_name(name)
  	all.find do |value|
  		value.name.downcase == name.downcase
  	end
  end

  def find_all_by_merchant_id(id)
    all.find_all do |value|
      value.merchant_id == id
    end
  end

  def find_all_by_invoice_id(id)
    all.find_all do |value|
      value.invoice_id == id
    end
  end

  def find_all_by_customer_id(id)
    all.find_all do |value|
      value.customer_id == id
    end
  end

  def update (id, update)
    value_need_update = find_by_id(id)
    value_need_update.update_attributes(update) unless value_need_update == nil
  end

  def max_id
    max_id = (all.max_by{|value| value.id.to_i}).id.to_i
  end

  def new_id
    max_id + 1
  end

  def delete(id)
    @collections.delete_if do |key,value|
      value.id == id
    end
  end
end

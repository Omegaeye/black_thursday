require 'time'
require_relative './merchant_repository'

class Merchant

  attr_accessor :updated_at,
                :name
  attr_reader   :id,
                :created_at

  def initialize(data, repository)
    @repository  = repository
    @id          = data[:id].to_i
    @name        = data[:name]
    @created_at  = Time.parse(data[:created_at].to_s)
    @updated_at  = Time.parse(data[:updated_at].to_s)
  end

  def update_attributes (new_attributes)
    @name       = new_attributes[:name]
    @updated_at = new_attributes[:updated_at] = Time.now
  end
end

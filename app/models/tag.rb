# Mongoid Tag Model
class Tag
  include Mongoid::Document
  field :name, type: String

  has_many :to_dos
end

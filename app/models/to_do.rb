# Mongoid ToDo Model
class ToDo
  include Mongoid::Document
  field :name, type: String
  field :description, type: String
  field :status, type: String
  field :tag_id, type: Integer
  field :is_deleted, type: Boolean, default: false

  belongs_to :tag

  validates :status, inclusion: { in: %w[start finish not_start],
                                  message: 'status is invalid' },
                     allow_nil: false
end

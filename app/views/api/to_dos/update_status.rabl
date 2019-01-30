object @to_do

attributes :name, :description, :status, :tag_id
node(:id) {|t| t.id.to_s}
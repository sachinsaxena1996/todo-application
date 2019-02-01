require 'rails_helper'

RSpec.describe Tag, type: :model do
  it { is_expected.to have_field(:name).of_type(String) }
  it { is_expected.to have_many :to_dos }
end

require 'rails_helper'

RSpec.describe ToDo, type: :model do
  describe 'validation' do
    let!(:tag) { Tag.create(name: 'tag 1') }
    let!(:to_do_1) do
      ToDo.create(name: 'todo 1', description: 'for doing',
                  status: 'start', tag_id: tag.id, is_deleted: false)
    end

    it { is_expected.to have_field(:name).of_type(String) }
    it { is_expected.to have_field(:description).of_type(String) }
    it { is_expected.to have_field(:status).of_type(String) }
    it { is_expected.to have_field(:tag_id).of_type(Object) }
    it {
      is_expected.to have_field(:is_deleted).of_type(Mongoid::Boolean)
                                            .with_default_value_of(false)
    }
    it { is_expected.to belong_to(:tag) }
    it {
      is_expected.to validate_inclusion_of(:status)
        .to_allow('start', 'finish', 'not_start')
    }
  end
end

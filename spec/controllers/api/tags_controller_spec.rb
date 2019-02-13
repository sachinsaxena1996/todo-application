require 'rails_helper'

RSpec.describe Api::TagsController, type: :controller do
  render_views

  describe 'get /api/tags/:id/todos' do
    let!(:tag) { Tag.create(name: 'tag 1') }
    let!(:to_do_1) do
      ToDo.create(name: 'todo 1', description: 'for doing',
                  status: 'start', tag_id: tag.id, is_deleted: false)
    end
    let!(:to_do_2) do
      ToDo.create(name: 'todo 2', description: 'for doing 2',
                  status: 'start', tag_id: tag.id, is_deleted: false)
    end
    it 'finds all the todo items by tag' do
      get :todos, tag_name: tag.name
      json = JSON.parse(response.body)
      expect(json.length).to eq(2)
    end
  end
end

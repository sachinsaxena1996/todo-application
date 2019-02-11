require 'rails_helper'

# rubocop:disable Metrics/BlockLength
RSpec.describe Api::ToDosController, type: :controller do
  render_views

  describe 'get /api/to_dos' do
    let!(:tag) { Tag.create(name: 'tag 1') }
    let!(:to_do_1) do
      ToDo.create(name: 'todo 1', description: 'for doing',
                  status: 'start', tag_id: tag.id, is_deleted: false)
    end
    let!(:to_do_2) do
      ToDo.create(name: 'todo 2', description: 'for doing 2',
                  status: 'not_start', tag_id: tag.id, is_deleted: false)
    end
    it 'shows all to_dos' do
      get :index
      json = JSON.parse(response.body)
      expect(json.length).to eq(2)
      expect(json[0]).to match(a_hash_including(
                                 '_id' => { '$oid' => to_do_1.id.to_s },
                                 'name' => to_do_1.name,
                                 'description' => to_do_1.description,
                                 'status' => to_do_1.status,
                                 'tag_id' => {
                                   '$oid' => tag.id.to_s
                                 },
                                 'is_deleted' => to_do_1.is_deleted
      ))
    end
  end

  describe 'post /api/to_dos' do
    it 'creates the to_do' do
      post :create, to_do: { name: 'todo 1', description: 'for doing',
                             status: 'start', tag_id: '', is_deleted: false }
      expect(ToDo.count).to eq(1)
    end
  end

  describe 'put /api/to_dos/:id/status' do
    let!(:to_do_1) do
      ToDo.create(name: 'todo 1', description: 'for doing',
                  status: 'start', tag_id: '', is_deleted: false)
    end
    it 'updates the to_do status' do
      put :update_status, id: to_do_1.id, status: 'finish'
      expect(to_do_1.reload.status).to eq('finish')
    end
  end

  describe 'put /api/to_dos/:id/attach_tag' do
    let!(:to_do_1) do
      ToDo.create(name: 'todo 1', description: 'for doing',
                  status: 'start', tag_id: '', is_deleted: false)
    end
    it 'attaches a tag to the todo' do
      put :attach_tag, id: to_do_1.id, tag: { name: 'Attach Tag' }
      expect(to_do_1.reload.tag.name).to eq('Attach Tag')
    end
  end

  describe 'put /api/to_dos/:id' do
    let!(:tag) { Tag.create(name: 'tag 1') }
    let!(:to_do_1) do
      ToDo.create(name: 'todo 1', description: 'for doing',
                  status: 'start', tag_id: tag.id, is_deleted: false)
    end
    it 'updates the attributes of the to_do' do
      put :update, id: to_do_1.id, name: 'todo 2',
                   description: 'for doing 2', status: 'not_start'
      expect(to_do_1.reload.name).to eq('todo 2')
      expect(to_do_1.description).to eq('for doing 2')
      expect(to_do_1.status).to eq('not_start')
    end
  end

  describe 'delete /api/to_dos/:id' do
    let!(:tag) { Tag.create(name: 'tag 1') }
    let!(:to_do_1) do
      ToDo.create(name: 'todo 1', description: 'for doing',
                  status: 'start', tag_id: tag.id, is_deleted: false)
    end
    it 'marks the to_do as deleted' do
      delete :destroy, id: to_do_1.id
      expect(to_do_1.reload.is_deleted).to eq(true)
    end
  end

  describe 'put /api/to_dos/:id/is_deleted' do
    let!(:tag) { Tag.create(name: 'tag 1') }
    let!(:to_do_1) do
      ToDo.create(name: 'todo 1', description: 'for doing',
                  status: 'start', tag_id: tag.id, is_deleted: true)
    end
    it 'marks the to_do as not deleted' do
      put :undo_delete, id: to_do_1.id
      expect(to_do_1.reload.is_deleted).to eq(false)
    end
  end
end
# rubocop:enable Metrics/BlockLength

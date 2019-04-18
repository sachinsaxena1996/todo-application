Rails.application.routes.draw do
  namespace :api, constraints: { id: %r{[^\/]+} } do
    resources :to_dos, only: %i[index create update destroy show] do
      put 'status', on: :member, action: :update_status
      put 'is_deleted', on: :member, action: :undo_delete
      put 'attach_tag', on: :member, action: :attach_tag
    end

    resources :tags, except: %i[index create update destroy show] do
      get 'todos', on: :collection
    end
  end
end

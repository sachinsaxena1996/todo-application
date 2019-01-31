Rails.application.routes.draw do
  namespace :api, constraints: { id: %r{[^\/]+} } do
    resources :to_dos, only: %i[index create update destroy] do
      put 'status', on: :member, action: :update_status
      put 'is_deleted', on: :member, action: :undo_delete
      put 'attach_tag', on: :member, action: :attach_tag
      get 'find_to_dos', on: :collection
    end
  end
end

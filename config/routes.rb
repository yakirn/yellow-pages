Rails.application.routes.draw do
    # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
    scope 'api/v1' do
        resources :people, only: [:show] do
            get 'search', on: :collection
        end
    end
end

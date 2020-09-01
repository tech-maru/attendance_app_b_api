Rails.application.routes.draw do

  root 'static_pages#top'
  
  get '/signup', to: 'users#new'
  get '/index_result', to: 'users#index_result'
  get '/basic_info', to: 'users#basic_info'
  patch '/basic_info_update', to: 'users#basic_info_update'
  
  
  
  get '/login', to: 'sessions#new'
  get '/test_login', to: 'sessions#general_user'
  get '/test_admin', to: 'sessions#admin_user'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  
  resources :users do
    member do
      get 'one_week', to: 'users#show_one_week'
      get 'edit_basic_info'
      patch 'update_basic_info'
      get 'attendances/edit_one_month'
      get 'attendances/edit_one_week'
      patch 'attendances/all_update'
      get 'test_api'
    end
    resources :attendances, only: :update
  end
  
  namespace 'api' do
    namespace 'v1' do
      resources :posts, only: [:create] do
        post :login_date, on: :collection
        post :pick_attendance, on: :collection
        post :search_attendance, on: :collection
        patch :finished_at, on: :collection
      end
    end
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

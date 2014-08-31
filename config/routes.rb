Promoclub::Application.routes.draw do
  mount Rich::Engine => '/rich', :as => 'rich'

  resources :vacancies


  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'

  get "omniauth_callbacks/facebook"

  get "omniauth_callbacks/vkontakte"

  resources :articles
 
  get "/index.html", to: "static_pages#index"
  get "/o-proekte.html", to: "static_pages#about"
  get "/kontakti.html", to: "static_pages#contacts"
  get "/rabotodateli.html", to: "static_pages#rabotodateli"
  get "/statistika.html", to: "static_pages#statistika"
  get "/blog.html", to: "articles#index"
  get "/uslugi.html", to: "static_pages#services"
  get "/uslugi/poisk-promouterov.html", to: "static_pages#find"
  get "/uslugi/naiti-rabotu-promouterom.html", to: "static_pages#job"

# Пользователи
  get "/baza-promouterov.html", to: "users#index"
  match 'users/:id' => 'users#destroy', :via => :delete, :as => :admin_destroy_user

  # Отзывы о пользователе
    match "newopinion", :to => 'opinions#new'
    resources :opinions

  get 'users/update_states', :as => 'update_states'
  get 'users/update_cities', :as => 'update_cities'

  get 'cities/:city', to: 'users#index', as: :city

	devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  resources :users, :only => [:index, :show, :edit, :update, :destroy] do
    member do
      get :following, :followers
    end
  end
  resources :relationships, only: [:create, :destroy]

# Панель администратора
  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'

# Отправка сообщений
  match "messages/messagecreate", :to => 'messages#messagecreate'

  root :to => 'static_pages#index'

end

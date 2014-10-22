Promoclub::Application.routes.draw do
  mount Rich::Engine => '/rich', :as => 'rich'

  resources :vacancies do
    member do
      get :replies
    end
  end

  get "/my-vacancies.html", to: "vacancies#my_vacancies"

  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'

  get "omniauth_callbacks/facebook"

  get "omniauth_callbacks/vkontakte"

  resources :articles
 
  get "/index.html", to: "static_pages#index"
  get "/o-proekte.html", to: "static_pages#about"
  get "/kontakti.html", to: "static_pages#contacts"
  get "/vakansii-promouterov.html", to: "vacancies#index"
  get "/rabotodateli.html", to: "static_pages#rabotodateli"
  get "/statistika.html", to: "static_pages#statistika"
  get "/blog.html", to: "articles#index"
  get "/uslugi.html", to: "static_pages#services"
  get "/uslugi/poisk-promouterov.html", to: "static_pages#find"
  get "/uslugi/naiti-rabotu-promouterom.html", to: "static_pages#job"
  get "/help.html", to: "static_pages#help"
  get "/public-offer.html", to: "static_pages#public"

# Пользователи
  get "/baza-promouterov.html", to: "users#index"
  match 'users/:id' => 'users#destroy', :via => :delete, :as => :admin_destroy_user

  # Отзывы о пользователе
    match "newopinion", :to => 'opinions#new'
    resources :opinions

  get 'users/update_states', :as => 'update_states'
  get 'users/update_cities', :as => 'update_cities'

  get '/rabotodateli/cities/:city', to: 'static_pages#rabotodateli_cities', as: :agent_city
  get '/promoters/cities/:city', to: 'users#index', as: :promo_city
  get '/vacancies/cities/:city', to: 'vacancies#index', as: :vacancy_city

# Финансы пользователя
  match '/users/:id/payments', to: 'payments#index', as: :payments_user
  match '/payments/:id/destroy', to: 'payments#destroy', as: :destroy_payment
  match '/payments/create', to: 'payments#create'
  match '/payments/create_calculation', to: 'payments#create_calculation'
  match '/payments/edit_calculation', to: 'payments#edit_calculation', as: :edit_calculation
  match '/payments/new_period', to: 'payments#new_period'
  match '/payments/:id', to: 'payments#show', as: :payment

# Проплата
  scope 'robokassa' do
    match 'paid'    => 'robokassa#paid',    :as => :robokassa_paid # to handle Robokassa push request

    match 'success' => 'robokassa#success', :as => :robokassa_success # to handle Robokassa success redirect
    match 'fail'    => 'robokassa#fail',    :as => :robokassa_fail # to handle Robokassa fail redirect
  end  

	devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  resources :users, :only => [:index, :show, :edit, :update, :destroy] do
    member do
      get :following, :followers
      get :replies
      get :invites
    end
  end
  resources :relationships, only: [:create, :destroy]
  resources :replies, only: [:create, :destroy]
  resources :invites

# Панель администратора
  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'

# Отправка сообщений
  match "messages/messagecreate", :to => 'messages#messagecreate'

# Отправка sms-приглашений
  match "/vacancy/:id/sms_invite", :to => 'vacancies#sms_invites', as: :vacancy_sms_invite

  root :to => 'static_pages#index'

end

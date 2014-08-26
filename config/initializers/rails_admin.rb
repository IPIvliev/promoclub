# encoding: utf-8

# RailsAdmin config file. Generated on May 20, 2014 17:30
# See github.com/sferik/rails_admin for more informations

RailsAdmin.config do |config|
  # Set the admin name here (optional second array element will appear in red). For example:
  config.main_app_name = ['Клуб промоутеров', 'Admin']
  # or for a more dynamic name:
  # config.main_app_name = Proc.new { |controller| [Rails.application.engine_name.titleize, controller.params['action'].titleize] }

  config.included_models = ['Article', 'User', 'Message', 'Country', 'State', 'City']

  # RailsAdmin may need a way to know who the current user is]
  config.current_user_method { current_user } # auto-generated

  config.authenticate_with do
    warden.authenticate! scope: :user
  end
  config.current_user_method &:current_user

  # History
  config.audit_with :history, User

  # Edit Post model
    config.model Article do

      label_plural "Новости"
      weight 1

      list do
        field :picture do
          label "Изображение"
        end
        field :name do
          label "Название"
        end
        field :text do
          label "Текст"
        end
        field :created_at do
          label "Дата создания"
        end
      end

      edit do
        include_all_fields
        field :name do
          label "Название"
        end
        field :text do
          label "Текст"
        end
        exclude_fields :created_at, :updated_at, :user_id
      end
    end

    # Edit User model
    config.model User do
      label_plural 'Пользователи'
      weight 2

      list do
        field :name do
          label "Имя"
        end
        field :surname do
          label "Фамилие"
        end
        field :last_sign_in_at do
          label "Последнее посещение"
        end
        field :created_at do
          label "Дата создания"
        end
      end

      edit do
        include_all_fields
        field :name do
          label "Имя"
        end
        field :status do
          label "Статус"
        end
        exclude_fields :created_at, :reset_password_sent_at, :remember_created_at, :sign_in_count, :current_sign_in_at,
        :last_sign_in_at, :updated_at, :current_sign_in_ip, :last_sign_in_ip
      end

    end    

    # Edit Message model
    config.model Message do
      
      label_plural 'Сообщения'
      weight 3

      list do
        field :name do
          label "Имя"
        end
        field :email do
          label "Email"
        end
        field :text do
          label "Текст"
        end
        field :created_at do
          label "Дата создания"
        end
      end

      edit do
        field :name do
          label "Имя"
        end
        field :email do
          label "Email"
        end
        field :text do
          label "Текст"
        end
      end
    end

      # Edit Country model
    config.model Country do

      label_plural "Страны"
      weight 4

      list do
        field :name do
          label "Название"
        end
      end

      edit do
        field :name do
          label "Название"
        end
      end
    end

      # Edit State model
    config.model State do

      label_plural "Субъекты"
      weight 5

      list do
        field :name do
          label "Название"
        end
      end

      edit do
        field :name do
          label "Название"
        end
        field :country do
          label "Выбрать страну"
          nested_form false
        end
      end
    end

      # Edit City model
    config.model City do

      label_plural "Города"
      weight 6

      list do
        field :name do
          label "Название"
        end
      end

      edit do

        field :name do
          label "Название"
        end
        field :state do
          label "Выбрать субъект"
          nested_form false
        end
      end
    end


end

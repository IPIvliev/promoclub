# encoding: UTF-8

module ApplicationHelper

  def is_active(action)       
    params[:action] == action ? "active" : nil        
  end

  def javascript(*files)
    content_for(:head) { javascript_include_tag(*files) }
  end

  def stylesheet(*files)
    content_for(:head) { stylesheet_link_tag(*files) }
  end

  def profile_finish?
    if current_user
      if current_user.city.blank?
        flash[:warning] = "<strong>Вы не заполнили анкету</strong>. Для продолжения работы с сервисом необходимо указать ваши данные.".html_safe
        return redirect_to edit_user_path(current_user)
      end
    end
  end


end
class ErrorsController < ApplicationController
add_breadcrumb "Главная", :root_path, :title => "Вернуться на главную"

  def not_found
    @page_title = "404"
    add_breadcrumb @page_title

    render(:status => 404)
  end

  def internal_server_error
  	@page_title = "500"
    add_breadcrumb @page_title

    render(:status => 500)
  end
end
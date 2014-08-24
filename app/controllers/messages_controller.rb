# encoding: utf-8

class MessagesController < ApplicationController

  def messagecreate
    @message = Message.new(params[:message])

    if @message.save(params[:message])
      flash[:success] = "Ваше сообщение отправленно. Наш менеджер свяжется с Вами в ближайшее время."
    else
      flash[:danger] = "Сообщение не отправленно. Вы не заполнили, либо не правильно заполнили одно из обязательных полей."
    end
      redirect_to root_path
  end

end
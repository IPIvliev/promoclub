# encoding: UTF-8

module PaymentsHelper

  def payment_status(payment)
    case payment.pay
    when 0
      "<span class='red'>В ожидании оплаты</span>".html_safe
    when 1
      "<span class='green'>Оплачено</span>".html_safe
    end
  end

  def period_phone
  	@period = current_user.periods.last

  	if @period.blank?
  		"<p class='alert alert-danger'>Необходимо оплатить доступ к контактам промоутеров. Стоимость месяца доступа составляет
  		  #{money(Settings.period_price.to_i)}
          Оплатить доступ вы можете <strong>
          <a href='/users/#{current_user.id}/payments' class='red'>на странице личного счёта</a></strong>.</p>".html_safe
  	else
  		if @period.finish_date < Date.today
  			"<p class='alert alert-danger'>Ваш срок оплаты доступа к телефонам промоутеров истёк 
  			  #{Russian::strftime(@period.finish_date, "%d %B %Y года")}.
  			 Стоимость месяца доступа составляет
	  		  #{money(Settings.period_price.to_i)}
	          Оплатить доступ вы можете <strong>
	          <a href='/users/#{current_user.id}/payments' class='red'>на странице личного счёта</a></strong>.</p>".html_safe
  		elsif @period.finish_date >= Date.today
  			"<strong class='alert alert-success'><i class='fa fa-phone'></i> Номер телефона: #{@promoter.phone}</strong>".html_safe
  		end
  	end
  end

  def period_phone_reply(user)
  	@period = current_user.periods.last

  	if @period.blank?
  		"<a href='/users/#{current_user.id}/payments' class='red'>Оплатить доступ</a></strong>".html_safe
  	else
  		if @period.finish_date < Date.today
  			"<a href='/users/#{current_user.id}/payments' class='red'>Оплатить доступ</a></strong>".html_safe
  		elsif @period.finish_date >= Date.today
  			"<strong class='green'>#{user.phone}</strong>".html_safe
  		end
  	end
  end
  		
end
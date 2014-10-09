# encoding: utf-8

class InfoMailer < ActionMailer::Base
   default from: "allpromoters@yandex.ru"

  def info_email_promo(user)
  	@user = user
    mail(to: user.email, subject: 'Вы успешно зарегистрировались в сервисе "Клуб промоутеров"')
  end

  def info_email_agent(user)
  	@user = user
    mail(to: user.email, subject: 'Вы успешно зарегистрировались в сервисе "Клуб промоутеров"')
  end

  def info_email_common(user)
  	@user = user
    mail(to: user.email, subject: 'Вы успешно зарегистрировались в сервисе "Клуб промоутеров"')
  end
end
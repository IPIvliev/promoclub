# encoding: utf-8

class InfoMailer < ActionMailer::Base
   default from: "allpromoters@yandex.ru"

  def info_email_promo(user)
  	@user = user
    mail(to: user.email, subject: 'Ищите работу промоутером? Успешная регистрация')
  end

  def info_email_agent(user)
  	@user = user
    mail(to: user.email, subject: 'Ищите промоутеров? Успешная регистрация')
  end

  def info_email_common(user)
  	@user = user
    mail(to: user.email, subject: 'Вы успешно зарегистрировались в сервисе "Клуб промоутеров"')
  end

  def vacancy_email(user, vacancy)
    @vacancy = vacancy
    @user = user
    mail(to: user.email, subject: 'На сервиса "Клуб промоутеров" появилась подходящая для вас вакансия')
  end

end
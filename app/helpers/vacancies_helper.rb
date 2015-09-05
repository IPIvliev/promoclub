# encoding: UTF-8

module VacanciesHelper

  def email_invite_promos(vacancy)
    if vacancy.gender == "Не важно"
      User.where("status = ? AND city_id = ? AND (med = ? OR med = ?) AND sent = ?",
      "promo", vacancy.city_id, vacancy.med, true, true).each do |user_to|
      		InfoMailer.vacancy_email(user_to, vacancy).deliver_later
          # SendEmailJob.set(wait: 10.seconds).mailvacancy_later(user_to, vacancy)
      end
    else
      User.where("status = ? AND city_id = ? AND (med = ? OR med = ?) AND gender = ? AND sent = ?",
      "promo", vacancy.city_id, vacancy.med, true, vacancy.gender, true).each do |user_to|
      		InfoMailer.vacancy_email(user_to, vacancy).deliver_later
          # SendEmailJob.set(wait: 10.seconds).mailvacancy_later(user_to, vacancy)
      end
    end
  end

end

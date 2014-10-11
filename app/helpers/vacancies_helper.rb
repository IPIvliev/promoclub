# encoding: UTF-8

module VacanciesHelper

  def email_invite_promos(vacancy)
    if vacancy.gender == "Не важно"
      User.where("status = ? AND city_id = ? AND (med = ? OR med = ?)",
      "promo", vacancy.city_id, vacancy.med, true).each do |user_to|
      		InfoMailer.vacancy_email(user_to, vacancy).deliver
      end
    else
      User.where("status = ? AND city_id = ? AND (med = ? OR med = ?) AND gender = ?",
      "promo", vacancy.city_id, vacancy.med, true, vacancy.gender).each do |user_to|
      		InfoMailer.vacancy_email(user_to, vacancy).deliver
      end
    end
  end

end

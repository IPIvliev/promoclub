# encoding: UTF-8

module InvitesHelper

  def invite_promos(vacancy)
    case vacancy.gender
      when "Мужской"
        if vacancy.med == true
          User.where("status = ? AND city_id = ? AND med = ? AND gender = ?",
          "promo", vacancy.city_id, true, "Мужской").each do |user_to|
            invite = vacancy.user.invites.build(:user_to_id => user_to.id, :vacancy_id => vacancy.id)
            invite.save
          end
        else
          User.where("status = ? AND city_id = ? AND gender = ?",
          "promo", vacancy.city_id, "Мужской").each do |user_to|
            invite = vacancy.user.invites.build(:user_to_id => user_to.id, :vacancy_id => vacancy.id)
            invite.save
          end
        end
      when "Женский"
        if vacancy.med == true
          User.where("status = ? AND city_id = ? AND med = ? AND gender = ?",
          "promo", vacancy.city_id, true, "Женский").each do |user_to|
            invite = vacancy.user.invites.build(:user_to_id => user_to.id, :vacancy_id => vacancy.id)
            invite.save
          end
        else
          User.where("status = ? AND city_id = ? AND gender = ?",
          "promo", vacancy.city_id, "Женский").each do |user_to|
            invite = vacancy.user.invites.build(:user_to_id => user_to.id, :vacancy_id => vacancy.id)
            invite.save
          end
        end
      when "Не важно"
        if vacancy.med == true
          User.where("status = ? AND city_id = ? AND med = ?",
          "promo", vacancy.city_id, true).each do |user_to|
            invite = vacancy.user.invites.build(:user_to_id => user_to.id, :vacancy_id => vacancy.id)
            invite.save
          end
        else
          User.where("status = ? AND city_id = ?",
          "promo", vacancy.city_id).each do |user_to|
            invite = vacancy.user.invites.build(:user_to_id => user_to.id, :vacancy_id => vacancy.id)
            invite.save
          end
        end
    end
  end

end
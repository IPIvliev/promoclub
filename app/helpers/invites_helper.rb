# encoding: UTF-8

module InvitesHelper

  def invite_promos(vacancy)
    if vacancy.gender == "Не важно"
      User.where("status = ? AND city_id = ? AND (med = ? OR med = ?)",
      "promo", vacancy.city_id, vacancy.med, true).each do |user_to|
        invite = vacancy.user.invites.build(:user_to_id => user_to.id, :vacancy_id => vacancy.id)
        invite.save
      end
    else
      User.where("status = ? AND city_id = ? AND (med = ? OR med = ?) AND gender = ?",
      "promo", vacancy.city_id, vacancy.med, true, vacancy.gender).each do |user_to|
        invite = vacancy.user.invites.build(:user_to_id => user_to.id, :vacancy_id => vacancy.id)
        invite.save
      end
    end
  end

  def sms_invite_promos(vacancy)
    if vacancy.gender == "Не важно"
      User.where("status = ? AND city_id = ? AND (med = ? OR med = ?)",
      "promo", vacancy.city_id, vacancy.med, true).each do |user_to|
        RestClient.post(
          "http://sms.ru/sms/send", 
          :api_id => "9d3359eb-9224-2384-5d06-1118975a2cd2", 
          :to => user_to.phone, 
          :text => "Новая вакансия на http://allpromoters.ru Телефон: #{vacancy.user.phone}"
          )
        invite = vacancy.user.sms_invites.build(:user_to_id => user_to.id, :vacancy_id => vacancy.id)
        invite.save
      end
    else
      User.where("status = ? AND city_id = ? AND (med = ? OR med = ?) AND gender = ?",
      "promo", vacancy.city_id, vacancy.med, true, vacancy.gender).each do |user_to|
        RestClient.post(
          "http://sms.ru/sms/send", 
          :api_id => "9d3359eb-9224-2384-5d06-1118975a2cd2", 
          :to => user_to.phone, 
          :text => "Новая вакансия на http://allpromoters.ru Телефон: #{vacancy.user.phone}"
          )
        invite = vacancy.user.sms_invites.build(:user_to_id => user_to.id, :vacancy_id => vacancy.id)
        invite.save
      end
    end
  end

  def new_sms_count(vacancy)
    if vacancy.gender == "Не важно"
      all_users = User.where("status = ? AND city_id = ? AND (med = ? OR med = ?)", "promo", vacancy.city_id, vacancy.med, true).count
      send = vacancy.sms_invites.count
      amount = all_users - send
      if amount < 0
        return 0
      else
        return amount
      end
    else
      all_users = User.where("status = ? AND city_id = ? AND (med = ? OR med = ?) AND gender = ?",
      "promo", vacancy.city_id, vacancy.med, true, vacancy.gender).count
      send = vacancy.sms_invites.count
      amount = all_users - send
      if amount < 0
        return 0
      else
        return amount
      end
    end
  end

end
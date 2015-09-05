# encoding: UTF-8

module UsersHelper

# Сколько лет пользователю
  def calculate_age(birthday)
    Date.today.year - birthday.to_date.year
  end	

# Наличие медицинской книги
  def have_it(have)
  	if have
  		return "<span class='green'>В наличии<span>".html_safe
  	else
  		return "<span class='red'>Отсутсвует<span>".html_safe
  	end
  end

# Цветной рейтинг возле имени пользователя
  def color_rate(rate)
    if rate < 0
        return "<span class='red'>#{rate}</span>".html_safe
    elsif rate > 0
        return "<span class='green'>+#{rate}</span>".html_safe
    else
        return 0
    end
  end

# Сколько денег
  def money(summa)
    number_to_currency( summa, unit: "руб.", separator: ",", delimiter: " ", format: "%n %u")
  end

  def pay(cost)
    @new_pocket = current_user.pocket - cost
    current_user.update_attribute(:pocket, @new_pocket)
    return true
  end  
   
  def balance
      hash = RestClient.get("http://sms.ru/my/balance?api_id=9d3359eb-9224-2384-5d06-1118975a2cd2")
      hash[4..-1]
  end

#Meta данные
  def metachange(user)
    if user.status == "agent" || user.status == "admin"
      @page_title = "Рекламное агентство #{user.name}, город #{user.city.name}"
      @page_description = "Данные рекламного промо агентства  из города #{user.city.name}"
      @page_keywords    = "заказать промо в городе #{user.city.name}, рекламная акция #{user.city.name}, проведение дегустации, рекламное агенство #{user.name}, btl агентство #{user.name}, семплинг #{user.city.name}, дегустация"
    else
      @page_title = "Промоутер #{user.name} #{user.surname}, город #{user.city.name}"
      @page_description = "Контактыне данные промоутера из города #{user.city.name}"
      @page_keywords    = "#{user.city.name} промоутер, работа промоутером, данные для промо, промоперсонал, телефоны промоутеров, контакты для btl"
    end
  end

end

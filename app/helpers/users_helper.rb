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

end

# encoding: UTF-8

module UsersHelper

# Сколько лет пользователю
  def calculate_age(birthday)
    Date.today.year - birthday.to_date.year
  end	

# Наличие медицинской книги
  def medkniga(med)
  	if med
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
end

module UsersHelper

# Сколько лет пользователю
  def calculate_age(birthday)
    Date.today.year - birthday.to_date.year
  end	
end

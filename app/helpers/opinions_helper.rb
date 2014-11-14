# encoding: UTF-8

module OpinionsHelper

  def opinion_rate(opinion_rate)
    case opinion_rate
      when 1
        "<strong class='green'>позитивный</strong>".html_safe
      when 2
        "<strong class='red'>негативный</strong>".html_safe
    end
  end


  def opinion_rate_bg(opinion_rate)
    case opinion_rate
      when 1
        "#CDFCD1"
      when 2
        "#FCCDCD"
    end
  end

  def rate_factory(user_to, rate)
  	case rate
  		when 1
  			user = User.find(user_to)
  			user_rate = user.rate + 1

  			User.find(user_to).update_attribute(:rate, user_rate)
  		when 2
  			user = User.find(user_to)
  			user_rate = user.rate - 1

  			User.find(user_to).update_attribute(:rate, user_rate)
  	end
  end
end
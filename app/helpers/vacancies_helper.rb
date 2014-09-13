module VacanciesHelper

# Отправляем каждому пользователю приглашение принять участие в конкурсе на замещение вакансии
	def reply_to_each(vacancy, users)
		users.each do |user|
			vacancy.replies.create(:user_to => user)		
		end
	end

	def sms_reply_to_each(vacancy, users)
		users.each do |user|
			vacancy.replies.create(:user_to => user)		
		end
	end
end

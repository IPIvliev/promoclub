class SendEmailJob < ActiveJob::Base
  queue_as :default

  def mailvacancy(user_to, vacancy)
    InfoMailer.vacancy_email(user_to, vacancy).deliver_later
  end
end

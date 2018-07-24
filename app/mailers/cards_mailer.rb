class CardsMailer < ApplicationMailer
  default from: 'notifications@flashcards.com'

  def pending_cards_notification
    @users = User.joins(:cards).where("cards.review_date <= now()").distinct
    @url = 'ссылка'
    @users.each do |user|
      mail(to: user.email, subject: 'Карточки ожидают ревью')
    end
  end
end

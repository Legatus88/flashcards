class CardsMailer < ApplicationMailer
  default from: 'notifications@flashcards.com'

  def pending_cards_notification
    @users = User.includes(:cards).where("cards.review_date <= ?", Date.today).references(:cards)
    @url = 'ссылка'
    @users.each do |user|
      mail(to: user.email, subject: 'Карточки ожидают ревью')
    end
  end
end

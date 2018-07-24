class CardsMailer < ApplicationMailer
  default to: -> { User.all.select(&:any_cards_ready?).map(&:email) },
          from: 'notifications@flashcards.com'

  def pending_cards_notification
    @url  = 'ссылка'
    mail(subject: 'Карточки ожидают ревью')
  end
end

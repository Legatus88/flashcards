class HomeController < ApplicationController
  def index
    card_and_deck
  end

  def check
    @card = Card.find(params[:id])
    @result = SuperMemo.new(@card).translation_correct?(params[:user_text], params[:answer_time])

    if @result
      flash[:result] = t(:correct)      
    else
      flash[:result] = t(:wrong)
    end

    flash[:correct_word] = "#{t(:correct_word)}\"#{@card.original_text}\""
    flash[:users_word] = "#{t(:users_word)}\"#{params[:user_text]}\""
    
    respond_to do |format|
      format.html { render partial: 'check' }
      format.js
      card_and_deck
    end
  end

  private

  def card_and_deck
    @current_deck = current_user.current_deck
    @random_card = if @current_deck.nil?
                     current_user.cards.expired.sample
                   else
                     current_user.cards.deck(@current_deck).sample
                   end
  end
end
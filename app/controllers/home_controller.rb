class HomeController < ApplicationController
  def index
    @current_deck = current_user.current_deck
    @random_card = if @current_deck.nil?
      current_user.cards.expired.sample
    else
      current_user.cards.deck(@current_deck).sample
    end
  end

  def check
    @card = Card.find(params[:id])
    @result = SuperMemo.new(@card).translation_correct?(params[:user_text], params[:answer_time])

    if @result
      flash[:notice] = t(:correct)      
    else
      flash[:alert] = t(:alert)
    end

    flash[:correct_word] = "#{t(:correct_word)}\"#{@card.original_text}\""
    flash[:users_word] = "#{t(:users_word)}\"#{params[:user_text]}\""
    
    respond_to do |format|
      format.js
      @current_deck = current_user.current_deck
      @random_card = if @current_deck.nil?
                       current_user.cards.expired.sample
                     else
                       current_user.cards.deck(@current_deck).sample
                     end
    end
  end
end
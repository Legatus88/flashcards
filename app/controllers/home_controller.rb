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
  	@result = @card.translation_correct?(params[:user_text])

  	if @result
  	  flash[:notice] = t(:correct)
      flash[:correct_word] = "#{t(:correct_word)}\"#{@card.translated_text}\""
      flash[:users_word] = "#{t(:users_word)}\"#{params[:user_text]}\""
  	else
      flash[:alert] = t(:alert)
      flash[:correct_word] = "#{t(:users_word)}\"#{@card.translated_text}\""
  	  flash[:users_word] = "#{t(:users_word)}\"#{params[:user_text]}\""
  	end

  	redirect_to root_path
  end
end


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
  	  flash[:notice] = "Correct!"
  	else
  	  flash[:alert] = "Wrong!"
  	end

  	redirect_to root_path
  end
end


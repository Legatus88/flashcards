class HomeController < ApplicationController
  def index
    @random_card = Card.all.select { |c| c.review_date <= Date.today }.sample
  end

  def check
  	@card = Card.find(params[:id])
  	@result = @card.translation_correct?(params[:user_text], params[:translation])

  	if @result.eql? true
  	  flash[:notice] = "Correct!"
  	else
  	  flash[:error] = "Wrong!"
  	end

  	redirect_to root_path
  end
end

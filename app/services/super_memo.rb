class SuperMemo
  def initialize(card)
    @card = card
  end

  def translation_correct?(user_text, answer_time)
    if DamerauLevenshtein.distance(user_text, @card.original_text) <= 1
      modify_card(answer_time)
      true
    else
      false
    end
  end

  def modify_card(answer_time)
      @card.quality = choose_quality(answer_time.to_i).first
      ef_mod(@card.quality)
      next_step
      @card.save
  end

  def choose_quality(a_t)
    TIME.select { |_keys, values| values === a_t }.keys
  end

  TIME = {
    0 => 61..1000,
    1 => 26..60,
    2 => 16..25,
    3 => 7..15,
    4 => 4..6,
    5 => 1..3 
  }

  def ef_mod(q)
    if q < 3
      @card.step_number = 0
      @card.last_term = 1
      return
    end
    @card.e_factor += (0.1 - (5 - q)*(0.08 + (5 - q)*0.02))
    @card.e_factor = 1.3 if @card.e_factor < 1.3
  end

  def next_step
    if @card.step_number.eql? 0
      i = 1
    elsif @card.step_number.eql? 1
      i = 6
    elsif @card.step_number > 1
      i = @card.last_term*@card.e_factor
    end

    @card.step_number += 1
    @card.last_term = i.round
    @card.review_date = Date.today + @card.last_term
  end
end

  TIME = {
    0 => 100..1000,
    1 => 26..60,
    2 => 16..25,
    3 => 7..15,
    4 => 4..6,
    5 => 1..3 
  }


  def choose_quolity(a_t)
    TIME.select { |_keys, values| values === a_t }.keys
  end

puts choose_quolity(10)
require 'active_support/time'

  TIMES = {
    1 => 12.hour,
    2 => 3.days,
    3 => 7.days,
    4 => 14.days,
    5 => 1.months
  }

puts TIMES.select { |key, value| key.eql? 5 }.values.first.class
#a = DateTime.now + 1.day

a = 3.days
puts Date.today + 0.5.days + 0.5.days
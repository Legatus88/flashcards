class User < ApplicationRecord
  with_options presence:true do |a|
    a.validates :email
    a.validates :password
  end

  has_many :card
end

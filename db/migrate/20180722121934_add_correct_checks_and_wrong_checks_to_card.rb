class AddCorrectChecksAndWrongChecksToCard < ActiveRecord::Migration[5.2]
  def change
    add_column :cards, :correct_checks, :integer, default: '0'
    add_column :cards, :wrong_checks, :integer, default: '0'
  end
end

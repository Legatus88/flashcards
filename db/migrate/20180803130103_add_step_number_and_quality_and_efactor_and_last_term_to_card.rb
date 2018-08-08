class AddStepNumberAndQualityAndEfactorAndLastTermToCard < ActiveRecord::Migration[5.2]
  def change
    add_column :cards, :step_number, :integer, null: false, default: 0
    add_column :cards, :quality, :integer
    add_column :cards, :e_factor, :float, null: false, default: 2.5
    add_column :cards, :last_term, :integer
  end
end

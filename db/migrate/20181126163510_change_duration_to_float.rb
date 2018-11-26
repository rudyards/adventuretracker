class ChangeDurationToFloat < ActiveRecord::Migration[5.2]
  def change
    change_column :meetings, :duration, :float
  end
end

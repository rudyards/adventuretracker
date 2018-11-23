class AddDurationToMeetings < ActiveRecord::Migration[5.2]
  def change
    add_column :meetings, :duration, :integer
  end
end

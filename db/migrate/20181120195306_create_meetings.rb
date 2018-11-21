class CreateMeetings < ActiveRecord::Migration[5.2]
  def change
    create_table :meetings do |t|
      t.integer :game_id
      t.string :place
      t.datetime :time

      t.timestamps
    end
  end
end

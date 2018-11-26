class AddTimezoneColumnToGames < ActiveRecord::Migration[5.2]
  def change
    add_column :games, :timezone, :string, default: "UTC"
  end
end

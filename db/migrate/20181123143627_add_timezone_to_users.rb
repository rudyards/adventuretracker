class AddTimezoneToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :timezone, :string, default: "PST"
  end
end

class Update < ActiveRecord::Migration[5.2]
  def change
    rename_column :Users, :name, :username
  end
end

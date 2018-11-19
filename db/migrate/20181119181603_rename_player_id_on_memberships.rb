class RenamePlayerIdOnMemberships < ActiveRecord::Migration[5.2]
  def change
    rename_column :memberships, :player_id, :user_id
  end
end

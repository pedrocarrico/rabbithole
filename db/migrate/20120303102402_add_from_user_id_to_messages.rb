class AddFromUserIdToMessages < ActiveRecord::Migration
  def change
    add_column :messages, :from_user_id, :integer
  end
end

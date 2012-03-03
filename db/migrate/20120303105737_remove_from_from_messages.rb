class RemoveFromFromMessages < ActiveRecord::Migration
  def up
    remove_column :messages, :from
  end

  def down
    add_column :messages, :from, :string
  end
end

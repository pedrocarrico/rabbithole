class RemoveToFromMessages < ActiveRecord::Migration
  def up
    remove_column :messages, :to
  end

  def down
    add_column :messages , :to, :string
  end
end

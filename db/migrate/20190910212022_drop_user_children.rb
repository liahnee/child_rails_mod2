class DropUserChildren < ActiveRecord::Migration[6.0]
  def change
    drop_table :user_children
  end
end

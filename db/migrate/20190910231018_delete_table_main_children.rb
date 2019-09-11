class DeleteTableMainChildren < ActiveRecord::Migration[6.0]
  def change
    drop_table :main_children
  end
end

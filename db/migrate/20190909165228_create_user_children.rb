class CreateUserChildren < ActiveRecord::Migration[6.0]
  def change
    create_table :user_children do |t|
      t.reference :users, user_id: true
      t.reference :children, child_id: true

      t.timestamps
    end
  end
end

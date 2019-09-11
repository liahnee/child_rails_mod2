class CreateMainChild < ActiveRecord::Migration[6.0]
  def change
    create_table :main_children do |t|
      t.references :child, index: true, foreign_key:true
      t.references :user, index:true, foreign_key:true

      t.timestamps
    end
  end
end

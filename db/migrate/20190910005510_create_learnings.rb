class CreateLearnings < ActiveRecord::Migration[6.0]
  def change
    create_table :learnings do |t|
      t.string :action

      t.timestamps
    end
  end
end

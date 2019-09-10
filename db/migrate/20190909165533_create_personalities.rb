class CreatePersonalities < ActiveRecord::Migration[6.0]
  def change
    create_table :personalities do |t|
      t.reference :child_id, index: true, foreign_key: {to_table: :children}
      t.reference :learning_interest, index: true, foreign_key: {to_table: :learnings}
      t.reference :hobby_interest, index: true, foreign_key: {to_table: :hobbies}

      t.string :social_trait
      t.string :learning_trait

      t.timestamps
    end
  end
end

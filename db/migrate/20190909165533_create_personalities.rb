class CreatePersonalities < ActiveRecord::Migration[6.0]
  def change
    create_table :personalities do |t|
      t.references :child, index: true
      t.references :learning_interest, index: true, foreign_key: {to_table: :learnings}
      t.references :hobby_interest, index: true, foreign_key: {to_table: :hobbies}

      t.string :social_trait
      t.string :learning_trait

      t.timestamps
    end
  end
end

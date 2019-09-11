class CreateChildren < ActiveRecord::Migration[6.0]
  def change
    create_table :children do |t|
      t.string :first_name
      t.string :last_name
      
      t.float :age
      t.string :gender
      
      t.float :ambition
      t.float :happiness
      t.float :social

      t.float :art
      t.float :coding
      t.float :language
      t.float :mathematic

      t.references :job
      t.references :personality
      t.references :user

      t.timestamps
    end
  end
end

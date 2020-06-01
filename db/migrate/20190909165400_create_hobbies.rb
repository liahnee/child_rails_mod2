class CreateHobbies < ActiveRecord::Migration[6.0]
  def change
    create_table :hobbies do |t|
      t.string :action

      t.timestamps
    end
  end
end

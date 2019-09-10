class CreateSocializations < ActiveRecord::Migration[6.0]
  def change
    create_table :socializations do |t|
      t.string :action
      t.integer :value

      t.timestamps
    end
  end
end

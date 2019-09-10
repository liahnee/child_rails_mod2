class CreateJobs < ActiveRecord::Migration[6.0]
  def change
    create_table :jobs do |t|
      t.string :title

      t.float :happiness
      t.float :ambition
      
      t.float :language
      t.float :mathematic
      t.float :coding
      t.float :art

      t.timestamps
    end
  end
end

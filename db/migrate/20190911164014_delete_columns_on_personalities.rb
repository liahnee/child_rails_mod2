class DeleteColumnsOnPersonalities < ActiveRecord::Migration[6.0]
  def change
    remove_column :personalities, :hobby_interest_id
    remove_column :personalities, :learning_interest_id
    
    add_column :personalities, :learning_id, :integer
    add_column :personalities, :hobby_id, :integer
  end
end

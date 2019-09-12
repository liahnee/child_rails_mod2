class AddTempJobIdToChildren < ActiveRecord::Migration[6.0]
  def change
    add_column :children, :temp_job_id, :integer
  end
end

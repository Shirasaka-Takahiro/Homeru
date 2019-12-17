class AddReportIdToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :report_id, :integer
  end
end

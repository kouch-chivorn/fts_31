class AddStatusToTests < ActiveRecord::Migration
  def change
    add_column :tests, :status, :string, default: "Start"
  end
end

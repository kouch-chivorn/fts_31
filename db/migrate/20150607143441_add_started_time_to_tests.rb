class AddStartedTimeToTests < ActiveRecord::Migration
  def change
    add_column :tests, :started_time, :datetime
  end
end

class CreateTests < ActiveRecord::Migration
  def change
    create_table :tests do |t|
      t.references :user, index: true
      t.references :category, index: true
      t.integer :result

      t.timestamps null: false
    end
    add_foreign_key :tests, :users
    add_foreign_key :tests, :categories
  end
end

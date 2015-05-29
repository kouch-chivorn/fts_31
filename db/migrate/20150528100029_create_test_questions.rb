class CreateTestQuestions < ActiveRecord::Migration
  def change
    create_table :test_questions do |t|
      t.references :test, index: true
      t.references :question, index: true
      t.references :answer, index: true

      t.timestamps null: false
    end
    add_foreign_key :test_questions, :tests
    add_foreign_key :test_questions, :questions
    add_foreign_key :test_questions, :answers
  end
end

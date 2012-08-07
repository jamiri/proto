class CreateQuestions< ActiveRecord::Migration
  def change

    create_table :questions do |t|

      t.integer :lesson_id
      t.integer :user_id
      t.string  :question
      t.string  :answer
      t.string  :answered_by

      t.timestamps
    end

  end
end
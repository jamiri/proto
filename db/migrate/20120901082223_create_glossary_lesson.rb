class CreateGlossaryLesson < ActiveRecord::Migration

  def change

    create_table :glossary_entries_lessons, :id => false do |t|
      t.integer :glossary_entry_id
      t.integer :lesson_id
    end

  end

end

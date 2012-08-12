class CreateGlossaryEntries < ActiveRecord::Migration

  def change

    create_table :glossary_entries do |t|

      t.string :entry

      # Short definition that will be appeared in the lesson
      t.string :short_definition

      # Full definition that is will be appeared in the glossary section
      t.text :full_definition

      t.timestamps

    end

  end
end


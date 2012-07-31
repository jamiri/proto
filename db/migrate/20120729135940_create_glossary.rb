class CreateGlossary < ActiveRecord::Migration

  def change

    create_table :glossary do |t|

      t.string :Word
      t.string :definition
      t.text :article
      t.string :lookup_words
      t.timestamps

    end

  end
end


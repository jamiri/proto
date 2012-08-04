class CreateGlossary < ActiveRecord::Migration

  def change

    create_table :glossary do |t|

      t.string :word
      t.string :definition
      t.text :article
      t.string :lookup_words
      t.timestamps

    end

  end
end


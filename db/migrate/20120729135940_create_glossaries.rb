class CreateGlossaries < ActiveRecord::Migration

  def change

    create_table :glossaries do |t|

      t.string :word
      t.string :definition
      t.text :article
      t.string :lookup_words
      t.timestamps

    end

  end
end


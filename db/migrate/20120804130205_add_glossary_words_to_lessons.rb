class AddGlossaryWordsToLessons < ActiveRecord::Migration

  def change

    # A comma separated string to specify those words whose their meaning should be
    # fetched from glossary
    add_column :lessons, :glossary_words, :string

  end


end
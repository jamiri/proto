class CreateContentSuggestions < ActiveRecord::Migration

  def change
    create_table :content_suggestions do |t|

      t.string :name
      t.string :email
      t.string :subject
      t.string :content

      t.timestamps

    end
  end

end

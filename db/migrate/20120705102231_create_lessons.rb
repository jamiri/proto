class CreateLessons < ActiveRecord::Migration

  def change

    create_table :lessons do |t|

      t.string :title
      t.string :description
      t.text :script
      t.string :audio_file
      t.string :video_file
      t.string :author

      t.integer :category_id

      t.timestamps

    end

  end
end


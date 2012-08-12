class CreateLessons < ActiveRecord::Migration

  def change

    create_table :lessons do |t|

      t.string :title
      t.string :description
      t.text :script
      t.float :average_rating
      t.string :audio_path
      t.string :video_path
      t.string :author

      # H. Samadi: I think publication_time should be removed. We already have timestamps.
      t.datetime :publication_time

      t.integer :category_id

      t.timestamps

    end

  end
end


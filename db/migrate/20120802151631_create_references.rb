class CreateReferences < ActiveRecord::Migration

  def change

    create_table :references do |t|

      t.integer :lesson_id
      t.string :title
      t.string :description
      t.string :photo

      t.timestamps

    end

  end
end


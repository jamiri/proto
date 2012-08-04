class CreateObjectives < ActiveRecord::Migration

  def change

    create_table :objectives do |t|

      t.integer :lesson_id
      t.string :title

      t.timestamps

    end

  end
end


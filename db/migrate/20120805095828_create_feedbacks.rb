class CreateFeedbacks < ActiveRecord::Migration

  def change
    create_table :feedbacks do |t|

      t.string :user_name
      t.string :email
      t.string :subject
      t.string :comment
      t.string :url
      t.integer :user_id

      t.timestamps

    end
  end

end

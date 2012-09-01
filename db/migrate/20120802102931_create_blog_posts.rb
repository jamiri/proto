class CreateBlogPosts< ActiveRecord::Migration
  # To change this template use File | Settings | File Templates.
  def change

    create_table :blog_posts do |t|

      t.integer :lesson_id
      t.string :title
      t.text :content

      t.timestamps

    end

  end
end
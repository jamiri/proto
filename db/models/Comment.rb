class Comment < ActiveRecord::Base

  belongs_to :blog_posts
  belongs_to :users

end
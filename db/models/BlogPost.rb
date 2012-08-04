class BlogPost < ActiveRecord::Base

  belongs_to :lessons
  has_many :comments, :foreign_key => 'blog_post_id'

end

class BlogPost < ActiveRecord::Base

  attr_accessible :title, :content

  belongs_to :lessons

  has_many :comments, :foreign_key => 'blog_post_id'

  def posted_on
    #TODO: decision: created_at or updated_at?
    created_at
  end
end

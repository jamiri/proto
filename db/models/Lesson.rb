class Lesson < ActiveRecord::Base

  belongs_to :category
  has_many :blog_posts, :foreign_key => 'lesson_id'
  has_many :objectives, :foreign_key => 'lesson_id'
  has_many :questions, :foreign_key => 'lesson_id'

end



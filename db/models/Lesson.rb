class Lesson < ActiveRecord::Base

  belongs_to :category

  has_many :blog_posts, :foreign_key => 'lesson_id', :limit => 5, :include => {:comments => [:user]}
  has_many :objectives, :foreign_key => 'lesson_id'
  has_many :questions, :foreign_key => 'lesson_id'
  has_many :references, :foreign_key => 'lesson_id'
  has_many :lesson_rating, :foreign_key => 'lesson_id'

end
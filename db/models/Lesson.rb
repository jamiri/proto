class Lesson < ActiveRecord::Base

  belongs_to :category

  has_many :blog_posts, :foreign_key => 'lesson_id', :limit => 5, :include => {:comments => [:user]}
  has_many :objectives, :foreign_key => 'lesson_id'
  has_many :questions, :foreign_key => 'lesson_id', :limit => 5
  has_many :references, :foreign_key => 'lesson_id'
  has_many :lesson_ratings, :foreign_key => 'lesson_id'
  has_and_belongs_to_many :glossary_entries

end
class LessonRating < ActiveRecord::Base

  belongs_to :lessons
  belongs_to :users


end
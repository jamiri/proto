class Question  < ActiveRecord::Base

  has_many :question_ratings, :foreign_key => 'question_id'

  belongs_to :lesson
  belongs_to :user

end
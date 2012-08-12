class Question  < ActiveRecord::Base

  belongs_to :lessons
  belongs_to :user

end
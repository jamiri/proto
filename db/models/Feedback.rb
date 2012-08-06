class Feedback  < ActiveRecord::Base
  attr_accessible :user_name, :email, :subject, :comment, :url

  has_one :user

end
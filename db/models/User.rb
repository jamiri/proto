class User < ActiveRecord::Base

  has_many :comments, :foreign_key => 'user_id'
  has_many :questions, :foreign_key => 'user_id'

end
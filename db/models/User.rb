class User< ActiveRecord::Base

  has_many :comments, :foreign_key => 'user_id'

end
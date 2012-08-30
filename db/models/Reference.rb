class Reference  < ActiveRecord::Base
  attr_accessible :title, :photo, :description

  belongs_to :lesson

end
class Objective < ActiveRecord::Base

  attr_accessible :title

  belongs_to :lesson

  def to_s
    title
  end

end
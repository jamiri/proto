class GlossaryEntry  < ActiveRecord::Base

  attr_accessible :name, :short_definition, :full_definition

  has_and_belongs_to_many :lessons

end
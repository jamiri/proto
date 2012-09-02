class GlossaryEntry  < ActiveRecord::Base

  attr_accessible :name, :short_definition, :full_definition,
                  :pronun_file, :image_file, :ext_link

  has_and_belongs_to_many :lessons

end
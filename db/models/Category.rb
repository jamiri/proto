class Category < ActiveRecord::Base

  has_many :sub_categories, :class_name => "Category",
           :foreign_key => "parent_id"
  belongs_to :parent, :class_name => "Category"

  has_many :lessons, :foreign_key => 'category_id'

end



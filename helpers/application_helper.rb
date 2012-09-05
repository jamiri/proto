# create an unordered list from a set of categories along with their descendants

# This code can be optimized
def create_child_for_category(root_categories)

  # the string that is going to be returned
  str = String.new

  root_categories.each do |p|

    str << "<li><a href='#'>#{p.name}</a>"

    if p.sub_categories.count > 0
      str << "<ul>#{create_child_for_category p.sub_categories}</ul>"
    end

    str << "</li>"
  end

  str

end

# This code can be optimized.
def create_navbar(id)

  # the string that is going to be returned
  str = ""

  cat = Category.find(id)
  str = "<li><a href='#'>" << cat.name << "</a></li>" + str
  if cat.parent_id.nil?

    str

  else

   create_navbar(cat.parent_id) + str

  end

  # The variable 'from' and 'to' is type of date


end

def calculate_date_difference(from , to )

  dt = Date.parse(to.to_s) - Date.parse(from.to_s)

end



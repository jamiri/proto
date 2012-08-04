

# create an unordered list from a set of categories along with their descendants
#
def create_child_for_category(root_categories)

  # the string that is going to be returned
  str = ""

  root_categories.each do |p|

    str << "<li><a href='#'>#{p.name}</a>"

    if p.sub_categories.count > 0
      str << "<ul>#{create_child_for_category p.sub_categories}</ul>"
    end

    str << "</li>"
  end

  str

end




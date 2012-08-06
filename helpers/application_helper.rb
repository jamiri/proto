

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
def create_navbar(id)

  # the string that is going to be returned
  str = ""



      cat=Category.find(id)
      str= "<li><a href='#'>"<< cat.name<< "</a></li>"+str
  if(cat.parent_id.nil?)

    str

  else

     str= create_navbar(cat.parent_id)+str
    str

  end
end




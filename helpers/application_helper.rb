require "active_record"
require "./db/ar_config"
require_relative "../db/models/GlossaryEntry"

# create an unordered list from a set of categories along with their descendants
#
def create_child_for_category(root_categories)

  # the string that is going to be returned
  str = ""


  root_categories.each do |p|

    str += "<li ><a href='#'>"
    str += p.name + "</a>"

    if (p.sub_categories.count > 0)
      str += "<ul>"
      str += create_child_for_category p.sub_categories
      str += "</ul>"
    end

    str += "</li>"
  end

  str

end


#
def get_meaning_for(words_list)

  definition_list = []

  words = words_list.split(",")

  words.each do |word|


    definition = GlossaryEntry.find_by_entry(word).short_definition

    definition_list << definition

  end

  definition_list

end





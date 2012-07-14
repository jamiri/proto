require "active_record"
require "./db/ar_config"
require "./db/models/Category"
require "./helpers/application_helper"


class Main < Sinatra::Base


  before do
    @root_path = File.dirname(__FILE__)
  end


  # GET -> Root of the site

  get "/" do

    @categories = Category.where(:parent_id => nil)

    haml :index

  end



#--------------- Category Controller -------------------------------------

  get "/add/category" do
    haml :'create_category'
  end

  post "/add/category" do
    haml :"new_category"
  end

#--------------- End of Category Controller --------------------------------




#--------------- Lesson Controller ---------------------------------------

  # GET -> makes the page for entering the lesson data
  get "/add/lesson" do

    haml :'create_lesson'

  end

  # POST -> saves the lesson data in database
  post "/add/lesson" do
    haml :'new_lesson'
  end

#--------------- End of Lesson Controller ---------------------------------

end


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

    erb :index

  end



#***************************** Category Controller *************************************

  get "/add/category" do
    haml :'category/create'
  end


#---------------------------------------------------------------------------------------------


  post "/add/category" do
    category = params[:category]

    c = Category.new
    c.name = category[:name]
    c.parent = Category.where(:name => category[:parent]).first
    c.save

    haml :"category/new", :locals => {cat:c}
  end

#***************************** End of Category Controller ******************************




#***************************** Lesson Controller *************************************

  # GET -> makes the page for entering the lesson data
  get "/add/lesson" do

    haml :'create/lesson'

  end


#---------------------------------------------------------------------------------------------


  # POST -> saves the lesson data in database
  post "/add/lesson" do
    haml :'lesson/new'
  end

#***************************** End of Lesson Controller ***********************************

end


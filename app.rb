require "sinatra/base"
require "active_record"
require "./db/ar_config"
require "./db/models/Category"
require "./helpers/application_helper"
require_relative "admin"

class Main < Sinatra::Base

  # GET -> Root of the site

  get "/" do

    @categories = Category.where(:parent_id => nil)

    erb :index

  end



#***************************** Category Controller *************************************

  get "/category/add/?" do
    erb :'category/create'
  end


#---------------------------------------------------------------------------------------------


  post "/category/add/?" do
    category = params[:category]

    c = Category.new
    c.name = category[:name]
    c.parent = Category.where(:name => category[:parent]).first
    c.save


    erb :"category/new", :locals => {:cat => c}
  end

#***************************** End of Category Controller ******************************




#***************************** Lesson Controller *************************************

  # GET -> makes the page for entering the lesson data
  get "/lesson/add/?" do

    erb :'lesson/create'

  end


#---------------------------------------------------------------------------------------------


  # POST -> saves the lesson data in database
  post "/lesson/add/?" do
    erb :'lesson/new'
  end

#***************************** End of Lesson Controller ***********************************

  use SalaamPodAdmin


end
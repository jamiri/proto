require "sinatra/base"
require "active_record"
require "./db/ar_config"
require "./db/models/Category"
require "./helpers/application_helper"
require "sinatra/content_for2"
require "sinatra/reloader"
require 'sinatra_more/routing_plugin'
require_relative "admin"

class Main < Sinatra::Base

  register Sinatra::Reloader
  register SinatraMore::RoutingPlugin
  helpers Sinatra::ContentFor2
  # GET -> Root of the site

  map(:home).to('/')
  map(:view_lesson).to('/lesson')

  get :home do

    @categories = Category.where(:parent_id => nil)

    erb :index

  end

  # Temporary address for viewing the "lesson" page
  get :view_lesson do
    @categories = Category.where(:parent_id => nil)

    erb :'lesson/index'
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
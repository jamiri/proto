# require core classes and modules

require 'sinatra/base'
require "active_record"
require "sinatra/reloader"
require 'sinatra_more/markup_plugin'
require 'sinatra_more/routing_plugin'
require "sinatra/flash"
require "json"


# require configuration files

require "./db/ar_config"
require "./helpers/application_helper"
require_relative "admin"



# require models

require "./db/models/Category"
require "./db/models/GlossaryEntry"





class Main < Sinatra::Base


  configure :development do
    register Sinatra::Reloader
  end

  register SinatraMore::MarkupPlugin
  register SinatraMore::RoutingPlugin
  register Sinatra::Flash


  enable :sessions

  map(:index).to("/")

  map(:lesson).to("/lesson/:id")
  map(:lookup_words).to("/lesson/:id/lookup_words")



  #get :index do
  #  content_type :json
  #  { :key1 => 'value1', :key2 => 'value2' }.to_json
  #
  #end


  # GET -> Root of the site

  get :index do

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

  get :lesson do

    begin

      @lesson = Lesson.find(params[:id])

      message = @lesson.title

    rescue ActiveRecord::RecordNotFound

      message = "not_found"

    end




    erb :"lesson/show"

  end


  get :lookup_words do

    words = Lesson.find(params[:id]).glossary_words;

    definitions = get_meaning_for words
    content_type :json

    Hash[words.split(",").zip(definitions)].to_json

  end


#---------------------------------------------------------------------------------------------


# POST -> saves the lesson data in database
  post "/lesson/add/?" do
    erb :'lesson/new'
  end

#***************************** End of Lesson Controller ***********************************

  use SalaamPodAdmin


end
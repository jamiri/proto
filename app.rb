require "sinatra/base"
require "active_record"
require "./db/ar_config"
require "./helpers/application_helper"
require "sinatra/content_for2"
require "sinatra/reloader"
require "sinatra_more/routing_plugin"
require_relative "admin"
Dir[File.dirname(__FILE__) + "/db/models/*.rb"].each { |file| require file }

class Main < Sinatra::Base

  register Sinatra::Reloader
  register SinatraMore::RoutingPlugin
  register SinatraMore::MarkupPlugin
  helpers Sinatra::ContentFor2

  map(:home).to('/')
  map(:view_lesson).to('/lesson/:id')
  map(:feedback).to('/feedback')

  set :ref_img_dir, 'assets/ref_img'

  get :home do

    @categories = Category.where(:parent_id => nil)

    erb :index

  end

  # ----- Lesson -----

  get :view_lesson do
    #exception handling required!

    @lesson = Lesson.find(params[:id])
    @categories = Category.where(:parent_id => nil)

    erb :'lesson/index'
  end

  # ----- Feedback -----

  post :feedback do
    fb = params[:feedback]

    feedback = Feedback.new
    feedback.user_name = fb['user_name']
    feedback.email = fb['email']
    feedback.subject = fb['subject']
    feedback.comment = fb['comment']
    feedback.url = fb['url']

    feedback.save
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
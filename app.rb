require "sinatra/base"
require "active_record"
require "./db/ar_config"
require "./helpers/application_helper"
require "sinatra/content_for2"
require "sinatra/reloader"
require "sinatra_more/routing_plugin"
require_relative "admin"
Dir[File.dirname(__FILE__) + "/db/models/*.rb"].each {|file| require file }

class Main < Sinatra::Base

  register Sinatra::Reloader
  register SinatraMore::RoutingPlugin
  helpers Sinatra::ContentFor2

  map(:home).to('/')
  map(:view_lesson_fake).to('/lesson')
  map(:view_lesson).to('/lesson/:id')

  get :home do

    @categories = Category.where(:parent_id => nil)

    erb :index

  end

  # ----- Lesson -----

  # Temporary address for viewing the "lesson" page
  get :view_lesson_fake do
    @categories = Category.where(:parent_id => nil)
    erb :'lesson/index'
  end


  get :view_lesson do
    #exception handling required!

    @lesson = Lesson.find(params[:id])
    @categories = Category.where(:parent_id => nil)
    @questions=Question.where(:lesson_id=>1)

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




#***************************** End of Lesson Controller ***********************************

  use SalaamPodAdmin
  #use LessonController

end
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
  register SinatraMore::MarkupPlugin
  helpers Sinatra::ContentFor2

  map(:home).to('/')
  map(:view_lesson_fake).to('/lesson')
  map(:feedback).to('/feedback')
  map(:view_lesson).to('/lesson/:id')
  map(:view_audio).to('/files/audio/:file_name')
  map(:view_video).to('/files/video/:file_name')
  set :ref_img_dir, 'assets/ref_img'

  get :home do

    @categories = Category.where(:parent_id => nil)

    erb :index

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

  #*************************************** Begin Audio Controller **************************

  get :view_audio do


    File.read(File.join("files/audio", @params['file_name'])) # Get the file path

  end

  #*************************************** End Audio Controller **************************



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
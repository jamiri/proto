require 'sinatra/base'
require 'sinatra_more/markup_plugin'
require 'sinatra_more/routing_plugin'
require "active_record"
require_relative "db/ar_config"
require_relative "db/models/Lesson"

class SalaamPodAdmin < Sinatra::Base

  register SinatraMore::MarkupPlugin
  register SinatraMore::RoutingPlugin
  register Sinatra::Flash

  enable :sessions
  set :views => 'views/admin'
  #set :erb, :layout => :admin_layout

  map(:index).to('/admin')
  map(:lesson_new).to("/admin/lesson/new")
  map(:lesson_create).to("/admin/lesson/create")

  get :index do
    erb :index
  end

  get :lesson_new do
    @lesson = Lesson.new

    erb :'lesson/new'
  end

  post :lesson_create do
    lsn = params[:lesson]

    lesson = Lesson.new
    lesson.title = lsn['title']
    lesson.description = lsn['description']
    lesson.script = lsn['script']
    lesson.author = lsn['author']

    lesson.save

    flash[:notice] = "New lesson has been successfully saved."

    redirect url_for(:index)
  end

end
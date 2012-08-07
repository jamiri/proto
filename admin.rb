require 'sinatra/base'
require 'sinatra_more/markup_plugin'
require 'sinatra_more/routing_plugin'
require "sinatra/flash"
require "active_record"
require_relative "db/ar_config"
require_relative "db/models/Lesson"
require_relative "db/models/Category"

class SalaamPodAdmin < Sinatra::Base

  register SinatraMore::MarkupPlugin
  register SinatraMore::RoutingPlugin
  register Sinatra::Flash

  enable :sessions
  set :views => 'views/admin'
  #set :erb, :layout => :admin_layout

  map(:index).to('/admin/?')
  map(:lesson_new).to("/admin/lesson/new")
  map(:lesson_create).to("/admin/lesson/create")
  #map category module for manage
  map(:category_new).to("/admin/category/new")
  map(:category_create).to("/admin/category/create")
  #map glossary module for manage
  map(:glossary_new).to("/admin/glossary/new")
  map(:glossary_create).to("/admin/glossary/create")

  get :index do
    erb :index
  end




  post :category_create do

    category = params[:category]

    c = Category.new
    c.name = category[:name]
    c.parent = Category.where(:name => category[:parent]).first
    c.save

    flash[:notice] = "New category has been successfully saved."

    redirect url_for(:index)


  end



  get :glossary_new do
    @glossary = Glossary.new

    erb :'glossary/new'
  end



  post :glossary_create do
    gn = params[:glossary]

    glossary = Glossary.new
    glossary.word = gn['word']
    glossary.definition = gn['definition']
    glossary.article = gn['article']
    glossary.lookup_words = gn['lookup_words']

    glossary.save

    flash[:notice] = "New glossary has been successfully saved."

    redirect url_for(:index)
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
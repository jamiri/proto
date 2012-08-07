require "sinatra/base"
require "active_record"
require "./db/ar_config"
require "./helpers/application_helper"
require "sinatra/reloader"
require "sinatra_more/routing_plugin"
require 'sinatra_more/markup_plugin'
require "sinatra/flash"
require "json"
require_relative "admin"
Dir[File.dirname(__FILE__) + "/db/models/*.rb"].each { |file| require file }

class Main < Sinatra::Base


  register Sinatra::Reloader
  register SinatraMore::RoutingPlugin
  register SinatraMore::MarkupPlugin
  register Sinatra::Flash


  map(:home).to('/')
  map(:feedback).to('/feedback')
  map(:sign_up).to('/sign_up')
  map(:view_lesson).to('/lesson/:id')
  map(:index).to(".")
  map(:lookup_words).to("/lesson/:id/lookup_words")


  configure :development do
    register Sinatra::Reloader
  end

  enable :sessions

  set :ref_img_dir, 'assets/ref_img'
  set :lesson_dir, 'assets/lesson_av'

  get :home do

    @categories = Category.where(:parent_id => nil)

    erb :index

  end

  # -----------Sign Up--------------------------
  post :sign_up do
    fb = params[:sign_up]

    user = User.new
    user.name = fb['name']
    user.mail_address = fb['mail_address']
    user.password = fb['password']

    user.save

    #flash[:notice] = "Your account Was Created ."

    redirect url_for(:index)

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

  get :view_lesson do
    #exception handling required!

    @lesson = Lesson.find(params[:id])
    @categories = Category.where(:parent_id => nil)

    erb :'lesson/index'
  end


  get :lookup_words do

    words = Lesson.find(params[:id]).glossary_words;

    definitions = get_meaning_for words
    content_type :json

    Hash[words.split(",").zip(definitions)].to_json

  end


  use SalaamPodAdmin


end
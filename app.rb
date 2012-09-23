require "sinatra/base"
require "active_record"
require "./db/ar_config"
require "./helpers/application_helper"
require "sinatra/content_for2"
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

  enable :sessions

  map(:home).to('/')
  map(:feedback).to('/feedback')
  map(:sign_up).to('/sign_up')
  map(:login).to('/login')
  map(:view_lesson).to('/lesson/:id')
  map(:lookup_words).to("/lesson/:id/lookup_words")
  map(:content_suggestion).to("/suggest_content")
  map(:sign_out).to('/sign_out')
  map(:question_page).to('/lesson/:lesson_id/question/page/:page')
  map(:fetch_microblog).to('/lesson/:lesson_id/microblog/:page')
  map(:lesson_rating).to('/lesson/:lesson_id/rating/:rate_val')

  #map(:question_rating).to(%r{/lesson/:lesson_id/question/:question_id/rating/(:rate_val#? | :rate_val )})
  map(:question_rating).to('/lesson/:lesson_id/question/:question_id/rating/:rate_val')

  map(:new_microblog).to('/lesson/:lesson_id/microblog/create')

  map(:lookup_term).to('/glossary/:term.json')


  configure :development do

    register Sinatra::Reloader

  end


  set :ref_img_dir, 'assets/ref_img'
  set :lesson_dir, 'assets/lesson_av'

  get :home do

    @top_lessons = Lesson.limit(4).order('created_at').reverse_order
    @categories = Category.where(:parent_id => nil)

    erb :index

  end

  # ----------- Begin Question Rating --------------------------------
  get :question_rating do

    question_id = params[:question_id]
    rate_val = params[:rate_val]

    vote = QuestionRating.new
    vote.question_id = question_id
    vote.user_id = 1
    vote.rating = rate_val

    vote.save

    QuestionRating.where(:question_id => question_id).average("rating").to_s


  end
  # ----------- End  Question Rating --------------------------------

  # ----------- Begin Lesson rating --------------------------------
  get :lesson_rating do

    lesson_id = params[:lesson_id]
    rate_val = params[:rate_val]

    vote = LessonRating.new
    vote.lesson_id = lesson_id
    vote.user_id = 1
    vote.rating = rate_val

    vote.save

    LessonRating.where(:lesson_id => lesson_id).average("rating").to_s


  end
  # ----------- End Lesson rating --------------------------------

  # -----------Sign Up--------------------------
  post :sign_up do
    fb = params[:sign_up]

    user = User.new
    user.name = fb['name']
    user.mail_address = fb['mail_address']
    user.password = fb['password']

    user.save

    #flash[:notice] = "Your account Was Created ."

    redirect url_for(:home)

  end

  #----------------- Sign In --------------------

  post :login do

    fb = params[:login]

    u = fb['user_name']
    p = fb['password']

    user = User.find_by_mail_address_and_password(fb['user_name'], fb['password'])

    if user.present? && user.enable

      session['user_name'] = u

    end

    redirect url_for(:home)

  end

  # -----------  Sign  out --------------------------

  get :sign_out do

    session['user_name'] = nil

    redirect url_for(:home)

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

  # ------------------- Question Make Page for ajax Interactions --------------------
  get :question_page do

    lesson_id = params[:lesson_id].to_s
    page = params[:page].to_i

    rows = Question.find(:all,
               :select => "questions.* , avg(question_ratings.rating) as rating_average",
               :conditions => ["questions.lesson_id=" + lesson_id],
               :joins => "left outer join question_ratings ON question_ratings.question_id = questions.id",
    :group => "questions.id",:offset => 5 * page , :limit => 5)

    content_type :json

    rows.to_json(:include => :user)

  end

  # ------------------------------------- Lesson -------------------------------------

  get :view_lesson do
    #exception handling required!

    @lesson = Lesson.where(:id => params[:id])
      .includes(:objectives, :references, :category , :lesson_ratings)
      .first

    @categories = Category.where(:parent_id => nil).includes(:sub_categories)

    @lesson_questions = Question.find(:all,
                         :select => "questions.* , avg(question_ratings.rating) as rating_average",
                         :conditions => ["questions.lesson_id=" + @lesson.id.to_s],
                         :joins => "left outer join question_ratings ON question_ratings.question_id = questions.id",
                         :group => "questions.id",:offset => 0 , :limit => 5)

    @avg_rate = @lesson.lesson_ratings.average("rating")

    erb :'lesson/index'

  end

  # ----- Load microblogs -----

  get :fetch_microblog do
    #TODO: exception handling required

    lesson_id = params[:lesson_id].to_i
    page = params[:page].to_i
    microblogs = BlogPost.where(:lesson_id => lesson_id).includes(:comments => :user).offset(5 * page).limit(5)

    content_type :json

    microblogs.to_json(:only => [:id, :title, :content], :methods => :posted_on, :include =>
        {:comments => {:include => :user}})

  end

  post :new_microblog do
    #TODO: exception handling

    comment_d = params[:comment]

    microblog = BlogPost.find(comment_d[:blog_post_id])

    microblog.comments << Comment.new(
        :comment => comment_d[:body],
        :user_id => 1
    )

    # TODO: the new comment should be returned.
    200 # return status code
  end


  get :lookup_words do
    # TODO: exception handling

    words = GlossaryEntry.joins(:lessons).where('lesson_id = ?', params[:id])

    content_type :json

    words.to_json(:only => [:id, :name, :short_definition])

  end

  get :lookup_term , :provides => :json do
    # TODO: exception handling

    halt 404 unless request.xhr?

    word = GlossaryEntry.where(:name => params[:term]).first

    halt 404 unless word

    word.to_json(:only => [:name, :short_definition, :full_definition, :image_file, :pronun_file, :ext_link])
  end

  # ----- Content Suggestion -----

  post :content_suggestion do

    fb = params[:content_suggestion]

    content_suggestion = ContentSuggestion.new

    content_suggestion.name = fb['name']
    content_suggestion.email = fb['email']
    content_suggestion.subject = fb['subject']
    content_suggestion.content = fb['content']

    content_suggestion.save

  end


  use SalaamPodAdmin

end
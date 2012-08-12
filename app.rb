require "sinatra/base"
require "active_record"
require "./db/ar_config"
require "./helpers/application_helper"
require "sinatra/content_for2"
require "sinatra/reloader"
require "sinatra_more/routing_plugin"
#------------ For Sending Mail --------------------------------
require 'tlsmail'
#-------------------------------------------------------------------
require_relative "admin"

Dir[File.dirname(__FILE__) + "/db/models/*.rb"].each {|file| require file }

set :session_secret, ENV["SESSION_KEY"] || 'too secret'

class Main < Sinatra::Base

  register Sinatra::Reloader
  register SinatraMore::RoutingPlugin
  register SinatraMore::MarkupPlugin
  helpers Sinatra::ContentFor2

  enable :sessions


  map(:home).to('/')
  map(:feedback).to('/feedback')
  map(:sign_up).to('/sign_up')
  map(:forgot_password).to('/forgot_password')
  map(:login).to('/login')
  map(:view_lesson).to('/lesson/:id')
  map(:index).to(".")
  map(:sign_out).to('/sign_out')
  map(:question_page).to('/lesson/:lesson_id/question/page/:page')

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

  # -----------  login  --------------------------

  post :login do

    fb = params[:login]

    u = fb['user_name']
    p = fb['password']

    #--------------- where command statement for checking password--------------

    user=User.where("mail_address='" + u + "' and password='" + p + "'")

   if user.count>0
      session['user_name']=u
   end
   #
   redirect url_for(:index)

  end

  # -----------  Sign  out --------------------------

  get :sign_out do

  session['user_name']=nil

  redirect url_for(:index)

  end



  #--------------- Sending Mail Method ------------------

  def send_email(to,subject,body,content,opts={})

    from = "iosie2012@gmail.com"
    p = "iosie2012"
    content = <<EOF
From: #{from}
To: #{to}
subject: #{subject}
Date: #{Time.now.rfc2822}
#{body}
EOF
    #print 'content', content

    Net::SMTP.enable_tls(OpenSSL::SSL::VERIFY_NONE)
    Net::SMTP.start('smtp.gmail.com', 587, 'gmail.com', from, p, :login) do |smtp|
      smtp.send_message(content, from, to)
    end
  end
  #--------------- recovery password ------------------
  post :forgot_password do

    fb = params[:forgot_password]
    u = params[:forgot_password]["mail_address"]

    #--------------- get password from db--------------
    user=User.where("mail_address='#{u}'")

    #--------------- Sending Email ---------------------
    user.each do |usr|

      send_email to=usr.mail_address,"Password Recovery From IOSIE","Password Recovery From IOSIE.Hello #{u}.\nThis is Your Password:#{usr.password}"

    end

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

  # ----- Get question row -----

  get :question_page do

    @lesson_id=params[:lesson_id].to_i
    @page=params[:page].to_i
    erb :'lesson/partial/question_row', :layout => false

  end


  # ----- Lesson -----

  get :view_lesson do
    #exception handling required!

    @lesson = Lesson.find(params[:id])
    @categories = Category.where(:parent_id => nil)

    erb :'lesson/index'
  end

  use SalaamPodAdmin

end
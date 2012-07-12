require "active_record"
require "./db/ar_config"
require "./db/models/Category"
require "./helpers/application_helper"


class Main < Sinatra::Base

  get "/" do

    @categories = Category.where(:parent_id => nil)

    haml :index

  end

  get "/asd" do

  end



end


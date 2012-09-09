require 'spec_helper'

describe "The SalaamPod prototype app" do

  it "should have a working homepage" do
    get '/'
    last_response.should be_ok
    last_response.body.should include("What's New?")
  end

  lesson = nil

  it "should have The Sample Lesson" do
    lesson = Lesson.where(:title => "Hijab in the Qur'an").first
    lesson.should_not be nil
    lesson.title.should be == "Hijab in the Qur'an"
  end

  it "should have a page for The Sample Lesson" do
    get "/lesson/#{lesson.id}"
    last_response.should be_ok
    last_response.body.should include(lesson.title)
  end

end
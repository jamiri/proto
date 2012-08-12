require_relative "../helpers/application_helper"

describe do




  it "should contain two separate defintions if called with Hijab and Islam" do

    words = "Hijab,Islam"
    result = get_meaning_for(words)

    result[0].should include("cover")
    result[1].should include("monotheistic")


  end


end
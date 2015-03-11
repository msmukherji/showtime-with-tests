require 'rails_helper'

describe MoviesController do
  render_views

  it "can list all the movies" do
    1.upto 5 do |i|
      FactoryGirl.create :movie
    end

    get :index

    expect(response.code.to_i).to eq 200

    json = response_json
    expect(json.class).to eq Array
    expect(json.count).to eq 5
    expect(json.last["title"]).to eq "Movie 5"
  end

  it "lets users stream movies"


  it "lets users stream only age appropriate movies"


  it "lets users check out movies"


  it "only lets users check out as many movies as their plan permits"

end
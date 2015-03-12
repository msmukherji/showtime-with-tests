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

  it "can stream movies if plan allows" do
    u = FactoryGirl.create :user, age: 13, stream: true
    login u
   
    movie = FactoryGirl.create :movie, rating: "pg-13"
   
    post :stream, movie_id: movie.id
    u.reload
    expect(u.stream_movie movie).to eq true
    expect(response.code.to_i).to eq 200
  end

  it "cant stream movies without streaming plan" do
    u = FactoryGirl.create :user, age: 13, stream: false
    login u
   
    movie = FactoryGirl.create :movie, rating: "pg-13"
   
    post :stream, movie_id: movie.id
    u.reload
    expect(u.stream_movie movie).to eq false
    expect(response.code.to_i).to eq 401
  end

  it "cant stream age inappropriate movies" do
    u = FactoryGirl.create :user, age: 12, stream: true
    login u

    movie = FactoryGirl.create :movie, rating: "r"

    post :stream, movie_id: movie.id
    expect(u.stream_movie movie).to eq false
    expect(response.code.to_i).to eq 401
  end

  
  it "can check out movies" do 
    u = FactoryGirl.create :user, age: 17, plan: 1
    login u

    movie = FactoryGirl.create :movie
   
    post :checkout, movie_id: movie.id
    u.reload
    expect(response.code.to_i).to eq 200
  end

  it "cant check out more movies than plan allows" do
    u = FactoryGirl.create :user, age: 17, plan: 1
    login u

    movie1 = FactoryGirl.create :movie
    movie2 = FactoryGirl.create :movie
    
    post :checkout, movie_id: movie1.id
    u.reload
    post :checkout, movie_id: movie2.id
    u.reload
    expect(response.code.to_i).to eq 401
  end

  it "cant check out age inappropriate movies" do
    u = FactoryGirl.create :user, age: 14, plan: 1
    login u

    movie = FactoryGirl.create :movie, rating: "r"
    
    post :checkout, movie_id: movie.id
    u.reload
    expect(response.code.to_i).to eq 401
  end

  it "can check in movies" do
    u = FactoryGirl.create :user
    login u

    m = FactoryGirl.create :movie

    UserMovie.create(user_id: u.id, movie_id: m.id)
    umct = UserMovie.count
    post :checkin, movie_id: m.id
    u.reload
    expect(response.code.to_i).to eq 200
    expect(UserMovie.count).to eq umct - 1
    expect(u.movies).not_to include m 
  end

end
require 'rails_helper'

# RSpec.describe User, type: :model do
#   pending "add some examples to (or delete) #{__FILE__}"
# end



describe User do
  
  it "can stream movies" do
    user  = FactoryGirl.create :user, age: 13, stream: true
    movie = FactoryGirl.create :movie, rating: "pg"
    
    expect(user.stream_movie movie).to eq true

    user2 = FactoryGirl.create :user, age: 13, stream: false
    expect(user2.stream_movie movie).to eq false
  end

  it "is old enough to stream movie" do
    user1 = FactoryGirl.create :user, age: 17, stream: true
    user2 = FactoryGirl.create :user, age: 14, stream: true
    movie = FactoryGirl.create :movie, rating: "r"

    expect(user1.stream_movie movie).to eq true
    expect(user2.stream_movie movie).to eq false
  end

  it "can check out movies if of age" do
    user = FactoryGirl.create :user, age: 13, plan: 1
    movie = FactoryGirl.create :movie, rating: "pg"

    expect(user.movies.count).to eq 0
    user.check_out_movie movie
    expect(user.movies.count).to eq 1
  end

  it "cant check out movies if not of age" do
    user = FactoryGirl.create :user, age: 7, plan: 1
    movie = FactoryGirl.create :movie, rating: "pg-13"

    expect(user.movies.count).to eq 0
    user.check_out_movie movie
    expect(user.movies.count).to eq 0
  end

  it "can check out movies if plan permits" do
    user = FactoryGirl.create :user, age: 13, plan: 1
    movie = FactoryGirl.create :movie, rating: "g"

    expect(user.movies.count).to eq 0
    user.check_out_movie movie
    expect(user.movies.count).to eq 1
  end

  it "cant check out more movies than plan permits" do
    user = FactoryGirl.create :user, age: 13, plan: 2
    movie1 = FactoryGirl.create :movie, rating: "pg"
    movie2 = FactoryGirl.create :movie, rating: "pg"
    movie3 = FactoryGirl.create :movie, rating: "pg"

    expect(user.movies.count).to eq 0
    user.check_out_movie movie1
    expect(user.movies.count).to eq 1

    user.check_out_movie movie2
    expect(user.movies.count).to eq 2

    user.check_out_movie movie3
    expect(user.movies.count).to eq 2
  end

  it "can check in movies" do
    user = FactoryGirl.create :user, age: 30, plan: 1
    movie = FactoryGirl.create :movie

    expect(user.movies.count).to eq 0
    user.check_out_movie movie
    expect(user.movies.count).to eq 1

    user.check_in_movie movie
    expect(user.movies.count).to eq 0
  end  

end


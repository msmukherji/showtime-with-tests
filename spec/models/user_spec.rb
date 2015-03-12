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

  it "is old enough to watch movie" do
    user1 = FactoryGirl.create :user, age: 17, stream: true
    user2 = FactoryGirl.create :user, age: 14, stream: true
    movie = FactoryGirl.create :movie, rating: "r"

    expect(user1.stream_movie movie).to eq true
    expect(user2.stream_movie movie).to eq false
  end

  it "can check out movies" do
    user = FactoryGirl.create :user, plan: 1
    movie = FactoryGirl.create :movie

    expect(user.movies.count).to eq 0

    user.check_out_movie movie
    expect(user.check_out_movie).to eq true
    expect(user.movies.count).to eq 1

    user.check_out_movie movie
    expect(user.check_out_movie).to eq false
    expect(user.movies.count).to eq 1
  end

  it "can check in movies" do
    user = FactoryGirl.create :user, plan: 1
    movie = FactoryGirl.create :movie

    expect(user.movies.count).to eq 0

    user.check_out_movie movie
    expect(user.check_out_movie).to eq true
    expect(user.movies.count).to eq 1

    user.check_in_movie movie
    expect(user.movies.count).to eq 0
  end  

  



end


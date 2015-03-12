require 'rails_helper'

# RSpec.describe UserMovie, type: :model do
#   pending "add some examples to (or delete) #{__FILE__}"
# end
describe UserMovie do

  it "can be checked out" do
    user = FactoryGirl.create :user, age: 13, plan: 1
    movie = FactoryGirl.create :movie, rating: "pg"

    expect(UserMovie.count).to eq 0
    user.check_out_movie movie
    expect(UserMovie.count).to eq 1
    
    expect(UserMovie.first.movie_id.to_i).to eq movie.id
    expect(UserMovie.first.user_id.to_i).to eq user.id
  end

  it "cant be checked out if user underage" do
    user = FactoryGirl.create :user, age: 13, plan: 1
    movie = FactoryGirl.create :movie, rating: "r"

    expect(UserMovie.count).to eq 0
    user.check_out_movie movie
    expect(UserMovie.count).to eq 0
  end

  it "cant be checked out if user has reached plan capacity" do
    user = FactoryGirl.create :user, age: 13, plan: 1
    movie1 = FactoryGirl.create :movie, rating: "g"
    movie2 = FactoryGirl.create :movie, rating: "g"

    expect(UserMovie.count).to eq 0
    user.check_out_movie movie1
    expect(UserMovie.count).to eq 1

    user.check_out_movie movie2
    expect(UserMovie.count).to eq 1

    expect(UserMovie.first.movie_id.to_i).to eq movie1.id
    expect(UserMovie.first.user_id.to_i).to eq user.id
  end

end
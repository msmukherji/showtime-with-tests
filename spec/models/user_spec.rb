require 'rails_helper'

# RSpec.describe User, type: :model do
#   pending "add some examples to (or delete) #{__FILE__}"
# end



describe User do
  it "can stream movies" do
    user  = FactoryGirl.create :user, age: 13, stream: true
    movie = FactoryGirl.create :movie, rating: "pg"

    expect(user.stream_movie).to eq true
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

  it "is old enough to watch movie"

  

end


class MoviesController < ApplicationController
  def index
    @movies = Movie.all
    render :home
  end
end
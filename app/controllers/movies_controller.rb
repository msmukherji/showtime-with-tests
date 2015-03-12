class MoviesController < ApplicationController
  def index
    @movies = Movie.all
    render :home
  end

  def stream
    movie = Movie.where(id: params[:movie_id]).first!
    if current_user.stream_movie movie
      head :ok
    else
      render :json => {:error => "Permission denied."}
    end
  end

  def checkout
  end

  def checkin
  end
  
end
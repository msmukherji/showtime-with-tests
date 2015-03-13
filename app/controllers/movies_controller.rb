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
      render :json => {:error => "Permission denied."}, status: 401
    end
  end

  def checkout
    movie = Movie.where(id: params[:movie_id]).first!
    if current_user.check_out_movie movie
      head :ok
    else
      render :json => {:error => "Permission denied."}, status: 401
    end
  end

  def checkin
    movie = Movie.where(id: params[:movie_id]).first!
    if current_user.check_in_movie movie 
      head :ok
    else
      render :json => {:error => "Unsuccessful."}, status: 401
    end
  end

end
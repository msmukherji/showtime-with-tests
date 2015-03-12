class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :user_movies
  has_many :movies, through: :user_movies

  def is_old_enough_to_watch movie

    rating = movie.rating
 
    age = self.age
    case rating
    when "r", "nc-17", "unrated"
      if age < 17
        false
      else
        true
      end
    when "pg-13"
      if age < 13
        false
      else
        true
      end
    else
      true
    end
  end

  def stream_movie m
    self.is_old_enough_to_watch(m) && self.stream
  end

  def check_out_movie m
    movies = self.movies.count
    unless movies >= self.plan.to_i
      if self.is_old_enough_to_watch m
        UserMovie.create(user_id: self.id, movie_id: m.id)
      end
    end
  end

  def check_in_movie m
    UserMovie.find_by(user_id: self.id, movie_id: m.id).delete
  end

end

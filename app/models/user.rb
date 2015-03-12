class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :user_movies
  has_many :movies, through: :user_movies

  # extend ActiveModel::Naming

  # def initialize
  #   @errors = ActiveModel::Errors.new(self)
  # end

  # attr_accessor :user
  # attr_reader   :errors

  # def validate!
  #   errors.add(:user, "not old enough") if user.age?....
  # end

  # # The following methods are needed to be minimally implemented

  # def read_attribute_for_validation(attr)
  #   send(attr)
  # end

  # def Person.human_attribute_name(attr, options = {})
  #   attr
  # end

  # def Person.lookup_ancestors
  #   [self]
  # end
  def is_old_enough_to_watch movie
    #binding.pry
    rating = movie.rating
    # WHY DOESN'T IT KNOW THAT SELF IS THE USER CREATED BY FG?
    age = self.age
    case rating
    when "r", "nc-17"
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
    self.is_old_enough_to_watch m and self.stream
  end
    #   #if self.class.is_old_enough_to_watch m
    #   # ^^ error saying age isn't a method on self
    #   if self.is_old_enough_to_watch m
    #   # ^^ error saying is_old_enough_to_watch isn't a method on self
    #     true
    #   else
    #     false
    #   end
    # else
    #   false
    # end


  def check_out_movie m
    movies = self.movies.count
    if movies >= self.plan
      false
    else
      UserMovie.create(user_id: self.id, movie_id: m.id)
    end
  end

  def check_in_movie m
    UserMovie.where(user_id: self.id, movie_id: m.id).delete
  end

end

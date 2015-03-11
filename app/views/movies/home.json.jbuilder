json.array! @movies do |movie|
  json.title movie.title
  json.movie_id movie.id
  json.rating  movie.rating
end
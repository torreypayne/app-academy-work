# == Schema Information
#
# Table name: actors
#
#  id          :integer      not null, primary key
#  name        :string
#
# Table name: movies
#
#  id          :integer      not null, primary key
#  title       :string
#  yr          :integer
#  score       :float
#  votes       :integer
#  director_id :integer
#
# Table name: castings
#
#  movie_id    :integer      not null, primary key
#  actor_id    :integer      not null, primary key
#  ord         :integer

require_relative './sqlzoo.rb'

def example_join
  execute(<<-SQL)
    SELECT
      *
    FROM
      movies
    JOIN
      castings ON movies.id = castings.movie_id
    JOIN
      actors ON castings.actor_id = actors.id
    WHERE
      actors.name = 'Sean Connery'
  SQL
end

def ford_films
  # List the films in which 'Harrison Ford' has appeared.
  execute(<<-SQL)
  SELECT title
  FROM movies
  INNER JOIN castings ON castings.movie_id = movies.id
  INNER JOIN actors ON actors.id = castings.actor_id
  WHERE actors.name = 'Harrison Ford'

  SQL
end

def ford_supporting_films
  # List the films where 'Harrison Ford' has appeared - but not in the star
  # role. [Note: the ord field of casting gives the position of the actor. If
  # ord=1 then this actor is in the starring role]
  execute(<<-SQL)
    SELECT title
    FROM movies
    INNER JOIN castings on castings.movie_id = movies.id
    INNER JOIN actors ON actors.id = castings.actor_id
    WHERE actors.name = 'Harrison Ford' AND ord > 1
  SQL
end

def films_and_stars_from_sixty_two
  # List the title and leading star of every 1962 film.
  execute(<<-SQL)
  SELECT movies.title, actors.name
  FROM movies
  INNER JOIN castings on castings.movie_id = movies.id
  INNER JOIN actors ON actors.id = castings.actor_id
  WHERE ord = 1 AND yr = 1962
  SQL
end

def travoltas_busiest_years
  # Which were the busiest years for 'John Travolta'? Show the year and the
  # number of movies he made for any year in which he made at least 2 movies.
  execute(<<-SQL)
  SELECT movies.yr, COUNT(movies.title)
  FROM movies
  INNER JOIN castings ON castings.movie_id = movies.id
  INNER JOIN actors ON actors.id = castings.actor_id
  GROUP BY movies.yr, actors.name
  HAVING COUNT(movies.title) > 1 AND actors.name = 'John Travolta'
  SQL
end

def andrews_films_and_leads
  # List the film title and the leading actor for all of the films 'Julie
  # Andrews' played in.
  execute(<<-SQL)
  SELECT movies.title, actors.name
  FROM movies
  INNER JOIN castings ON castings.movie_id = movies.id
  INNER JOIN actors ON actors.id = castings.actor_id
  WHERE castings.ord = 1 AND movies.title IN(
    SELECT title
    FROM movies AS movie1
    INNER JOIN castings AS casting1 ON movie1.id = casting1.movie_id
    INNER JOIN actors AS actor1 ON casting1.actor_id = actor1.id
    WHERE actor1.name = 'Julie Andrews'
    )

  -- GROUP BY movies.title, actors.name, castings.ord
  -- HAVING actors.name = 'Julie Andrews'
  SQL
end

def prolific_actors
  # Obtain a list in alphabetical order of actors who've had at least 15
  # starring roles.
  execute(<<-SQL)
  SELECT DISTINCT actors.name
  FROM actors
  INNER JOIN castings AS castings1 ON castings1.actor_id = actors.id
  INNER JOIN movies AS movies1 ON movies1.id = castings1.movie_id
  WHERE actors.name IN (
    SELECT actors.name
    FROM actors
    INNER JOIN castings ON castings.actor_id = actors.id
    INNER JOIN movies ON movies.id = castings.movie_id
    GROUP BY castings.ord, actors.name
    HAVING castings.ord = 1 AND COUNT(actors.name) >= 15
    )
  ORDER BY actors.name


  SQL
end

def films_by_cast_size
  # List the films released in the year 1978 ordered by the number of actors
  # in the cast (descending), then by title (ascending).
  execute(<<-SQL)
  SELECT movies.title, COUNT(actors.name)
  FROM movies
  INNER JOIN castings ON castings.movie_id = movies.id
  INNER JOIN actors ON actors.id = castings.actor_id
  WHERE movies.yr = 1978
  GROUP BY movies.title
  ORDER BY COUNT(actors.name) DESC, movies.title ASC

  SQL
end

def colleagues_of_garfunkel
  # List all the people who have played alongside 'Art Garfunkel'.
  execute(<<-SQL)
  SELECT DISTINCT actors.name
  FROM actors
  INNER JOIN castings ON castings.actor_id = actors.id
  INNER JOIN movies ON movies.id = castings.movie_id
  WHERE actors.name != 'Art Garfunkel' AND movies.title IN (
    SELECT movies1.title
    FROM movies AS movies1
    INNER JOIN castings AS castings1 ON castings1.movie_id = movies1.id
    INNER JOIN actors AS actors1 ON actors1.id = castings1.actor_id
    WHERE actors1.name = 'Art Garfunkel'
  )
  SQL
end

require 'rest-client'
require 'json'
require 'pry'

def get_character_movies_from_api(character)
  all_characters = RestClient.get('http://www.swapi.co/api/people/')
  character_hash = JSON.parse(all_characters)
  found_character = character_hash["results"].select { |result| result["name"].downcase == character }
  found_films = found_character[0]["films"]
  found_films
end

def parse_character_movies(found_films)
  puts "This person's films are:"

  found_films.map do |film|
    api_film = RestClient.get(film)
    parsed_film = JSON.parse(api_film)
    puts parsed_film["title"]
  end
end

def show_character_movies(character)
  films_hash = get_character_movies_from_api(character)
  parse_character_movies(films_hash)
end

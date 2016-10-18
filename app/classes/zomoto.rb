require 'data_fetch'
class Zomoto
  include DataFetch

  def initialize(city_id)
    @city_id = city_id
  end

  def restaurants
    # data = DataFetch::Main.get_restaurents @city_id #NOT IN WORKING lib/*.rb
    data = parse_response_of(scraping_api)
    result = []

    # parsing Zomoto data as required format
    data['restaurants'].each do |restaurant|
    result.push({
      restaurant_name: restaurant['restaurant']['name'],
      reviews_count: restaurant['restaurant']['user_rating']['votes'],
      address: {
        latitude: restaurant['restaurant']['location']['latitude'],
        longitude: restaurant['restaurant']['location']['longitude'],
        city: restaurant['restaurant']['location']['city'],
        zip_code: restaurant['restaurant']['location']['zipcode'],
      },
      rating: restaurant['restaurant']['user_rating']['aggregate_rating']
    })
  end
    result
  end

  def scraping_api
    zomoto_search_uri = "/search?entity_id=#{@city_id}&entity_type=city"

    response = HTTParty.get(ENV['zomoto_base_uri'] + zomoto_search_uri,
      :headers => {'Accept' => 'application/json','user-key' => ENV['zomoto_user_key']}
      )
  end

  def parse_response_of data
    data.parsed_response
  end

  def parse_response_for_json data
    JSON.parse(data.parsed_response)
  end

  # USING Net::HTTP
  # def get_restaurents_data1 city_id
  #   zomoto_search_uri = "/search?entity_id=#{city_id}&entity_type=city"

  #   uri = URI(ENV['zomoto_base_uri'] + zomoto_search_uri)
  #   http = Net::HTTP.new(uri.host, uri.port)

  #   headers = {
  #       'Accept' => 'application/json',
  #       'user-key' => ENV['zomoto_user_key']
  #   }
  #   http
  # end

  # def parse_response_of body
  #   JSON.parse(body)
  # end

  # def get_restaurents city_id
  #   data = get_restaurents_data1(city_id)
  #   parse_response_of(data)
  # end

end



module DataFetch
  include HTTParty

  class Main
    def self.get_restaurents city_id
      # zomoto_search_uri = "/search?entity_id=#{city_id}&entity_type=city"

      # response = HTTParty.get(ENV['zomoto_base_uri'] + zomoto_search_uri,
      #   :headers => {'Accept' => 'application/json','user-key' => ENV['zomoto_user_key']}
      #   )
      data = Main.get_restaurents_data(city_id)
      Main.parse_data(data)

      # data = Main.get_restaurents_data1 city_id
      # Main.parse_response_of data

    end

    def self.get_restaurents_data city_id
      zomoto_search_uri = "/search?entity_id=#{city_id}&entity_type=city"

      response = HTTParty.get(ENV['zomoto_base_uri'] + zomoto_search_uri,
        :headers => {'Accept' => 'application/json','user-key' => ENV['zomoto_user_key']}
        )
    end

    def self.get_restaurents_data1 city_id
      zomoto_search_uri = "/search?entity_id=#{city_id}&entity_type=city"

      uri = URI(ENV['zomoto_base_uri'] + zomoto_search_uri)
      http = Net::HTTP.new(uri.host, uri.port)

      headers = {
          'Accept' => 'application/json',
          'user-key' => ENV['zomoto_user_key']
      }

      path = uri.path.empty? ? "/" : uri.path

      #test to ensure that the request will be valid - first get the head
      code = http.head(path, headers).code.to_i
      if (code >= 200 && code < 300) then
        http
      end
    end

    def self.parse_data data
      data.parsed_response
    end

    def self.parse_response_of body
      JSON.parse(body)
    end

  end
end
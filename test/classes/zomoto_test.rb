require 'test_helper'
# require 'data_fetch'

class ZomotoTest < ActiveSupport::TestCase
  setup do
    # entity_id = 1 for New Delhi
    city_id = 1

    @zomoto = Zomoto.new(city_id)
    # crooked response
    response = File.read(Rails.root + 'test/test_data/zomoto_restaurants_crooked_data.json')

    # going for stub request
    stub_request(:get, "#{ENV['zomoto_base_uri']}/search?entity_id=#{city_id}&entity_type=city").
    with(:headers => {'Accept'=>'application/json', 'user-key' => ENV['zomoto_user_key']}).
    to_return(:body => response)
  end

  test 'should contain hash as response' do
    assert_kind_of Hash, @zomoto.parse_response_for_json(@zomoto.scraping_api),
    'Invalid response. Resonse should have valid JSON format.'
  end

  test 'should contain restaurants key' do
    assert_includes @zomoto.parse_response_for_json(@zomoto.scraping_api).keys, 'restaurants',
    'response not having restaurants key'
  end

  test 'should have Array as restaurants value' do
    assert_kind_of Array, @zomoto.parse_response_for_json(@zomoto.scraping_api)['restaurants'],
    'should contain Array as value of restaurants key'
  end

  # ============

  test 'should have restaurant name in restaurant[*]["restaurant"]["name"]' do
    assert_includes @zomoto.parse_response_for_json(@zomoto.scraping_api)['restaurants'][0]["restaurant"].keys,
    'name', 'should contain restaurant name in "name" key'
  end

  test 'should have restaurant location in restaurant[*]["restaurant"]["location"]' do
    assert_includes @zomoto.parse_response_for_json(@zomoto.scraping_api)['restaurants'][0]["restaurant"].keys,
    'location', 'should contain restaurant location in "location" key.'
  end

  test 'should have Hash as value in restaurant\'s location in restaurant[*]["restaurant"]["location"]' do
    assert_kind_of Hash, @zomoto.parse_response_for_json(@zomoto.scraping_api)['restaurants'][0]["restaurant"]['location'],
    'should contain Hash as restaurant[*]["restaurant"]["location"] value.'
  end

  test 'should have latitude key in restaurant[*][restaurant][location][latitude]' do
    assert_includes @zomoto.parse_response_for_json(@zomoto.scraping_api)['restaurants'][0]["restaurant"]['location'].keys,
    'latitude', 'should contain latitude restaurant[*]["restaurant"]["location"].'
  end

  test 'should have longitude key in restaurant[*][restaurant][location][latitude]' do
    assert_includes @zomoto.parse_response_for_json(@zomoto.scraping_api)['restaurants'][0]["restaurant"]['location'].keys,
    'longitude', 'should contain longitude restaurant[*]["restaurant"]["location"].'
  end

  test 'should have zipcode key in restaurant[*][restaurant][location][latitude]' do
    assert_includes @zomoto.parse_response_for_json(@zomoto.scraping_api)['restaurants'][0]["restaurant"]['location'].keys,
    'zipcode', 'should contain zipcode restaurant[*]["restaurant"]["location"].'
  end

  test 'should have city key in restaurant[*][restaurant][location][latitude]' do
    assert_includes @zomoto.parse_response_for_json(@zomoto.scraping_api)['restaurants'][0]["restaurant"]['location'].keys,
    'city', 'should contain city restaurant[*]["restaurant"]["location"].'
  end

  test 'should have restaurant user_rating in restaurant[*]["restaurant"]["user_rating"]' do
    assert_includes @zomoto.parse_response_for_json(@zomoto.scraping_api)['restaurants'][0]["restaurant"].keys,
    'user_rating', 'should contain restaurant user_rating in "user_rating" key.'
  end

  test 'should have Hash as value in restaurant\'s user_rating in restaurant[*]["restaurant"]["user_rating"]' do
    assert_kind_of Hash, @zomoto.parse_response_for_json(@zomoto.scraping_api)['restaurants'][0]["restaurant"]['user_rating'],
    'should contain Hash as restaurant[*]["restaurant"]["user_rating"] value.'
  end

  test 'should have votes key in restaurant[*][restaurant][location][votes]' do
    assert_includes @zomoto.parse_response_for_json(@zomoto.scraping_api)['restaurants'][0]["restaurant"]['user_rating'].keys,
    'votes', 'should contain votes restaurant[*]["restaurant"]["location"].'
  end

  test 'should have aggregate_rating key in restaurant[*][restaurant][location][aggregate_rating]' do
    assert_includes @zomoto.parse_response_for_json(@zomoto.scraping_api)['restaurants'][0]["restaurant"]['user_rating'].keys,
    'aggregate_rating', 'should contain aggregate_rating restaurant[*]["restaurant"]["location"].'
  end

end
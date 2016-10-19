ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

# addition
require "minitest/rails"
require "minitest/rails/capybara"
require "minitest/pride"

# crooking web response
require 'webmock/minitest'

class ActiveSupport::TestCase
  # check for all pending migrations
  ActiveRecord::Migration.check_pending!

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.

  fixtures :all

  # including factory girl
  include FactoryGirl::Syntax::Methods

  # Returns true if a test user is logged in.
  def is_logged_in?
    !session[:user_id].nil?
  end

end

class IntegrationTest < MiniTest::Spec
  include Rails.application.routes.url_helpers
  include Capybara::DSL
  register_spec_type(/integration$/, self)
end

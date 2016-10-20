require 'test_helper'

class RestaurantsControllerTest < ActionController::TestCase

  # setup do
  #   @auth_user = users(:auth)
  # end

  # test "should get index" do
  #   get :index
  #   # assert_response :success
  #   p "====gh===========#{assigns(:restaurants).inspect}"
  #   assert_nil assigns(:restaurants)
  # end

  # test "should get index" do
  #   # controller_name :sessons
  #   post login_sessions_path, params: { user: {
  #     email: @auth_user.email,
  #     password: 'aaaaaaaa'
  #     }
  #   }

  #   # should log in
  #   assert is_logged_in?



  #   # get :index
  #   # assert_not_nil assigns(:restaurants)
  # end

end



# describe "When Logged out" do
#   include MySpecHelper
#   controller_name :events

#   before(:each) do
#     controller.stub!(:current_user).and_return(:false)
#     @login_warning= "You need to be logged in to do that"
#   end

#   # test all actions require login except the ones specified
#   # add new_comment as it is not seen by the automatic collector
#   it "actions should fail" do
#     controller_actions_should_fail_if_not_logged_in(:input,
#                               :except => ['index', 'show', 'tagged'],
#                               :include => ['new_comment'])
#   end
# end
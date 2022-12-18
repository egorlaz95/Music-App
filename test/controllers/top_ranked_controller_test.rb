require 'test_helper'

class TopRankedControllerTest < ActionDispatch::IntegrationTest
  test 'should get top_ranked' do
    get top_ranked_top_ranked_url
    assert_response :success
  end
end

require 'test_helper'

class VideoControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get video_index_url
    assert_response :success
  end

  test "should get view" do
    get video_view_url
    assert_response :success
  end

end

require "test_helper"

class ChefSignupTest < ActionDispatch::IntegrationTest
  
  test "should get signup path" do
    get signup_path 
    assert_response :success
  end

  test "Reject an invalid sign up" do
    get signup_path
    assert_no_difference "Chef.count" do
      post chefs_path, params: {chef: {name: " ", email: " ", password: "password", password_confirmation: " "}}
    end
    assert_template 'chefs/new'
    assert_select 'h2.panel-title'
    assert_select 'div.panel-body'
  end

  test "Accept valid sign up" do
    get signup_path
    assert_difference "Chef.count", 1 do
      post chefs_path, params: {chef: {name: "Luz", email: "ChefLuz@example.com", password: "Lula_123", password_confirmation: "Lula_123"}}
    end
    follow_redirect!
    assert_template 'chefs/show'
    assert_not flash.empty?
  end

end

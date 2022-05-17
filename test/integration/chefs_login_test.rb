require "test_helper"

class ChefsLoginTest < ActionDispatch::IntegrationTest
  
  def setup 
    @chef = Chef.create!(name:"Lula",email:"cocinadelula@gmail.com",
      password:"Lula_123")
  end

  test "invalid login is rejected" do
    get login_path
    assert_template 'sessions/new'
    post login_path, params: {session: {email: " ", password: " "}}
    assert_template 'sessions/new'
    assert_not flash.empty?
    assert_select "a[href=?]", login_path #Check if the login path is still there (because i haven't logged in)
    assert_select "a[href=?]", logout_path,count: 0 #And logout shouldn't be present
    get root_path
    assert flash.empty?
  end

  test "valid login credentials accepted and begin session" do
    get login_path
    assert_template 'sessions/new'
    post login_path, params: {session: {email:@chef.email,password:@chef.password}}
    assert_redirected_to @chef
    follow_redirect!
    assert_template 'chefs/show'
    assert_not flash.empty?
    assert_select "a[href=?]", login_path,count: 0 #Check if the login path is gone (because i have already logged in)
    assert_select "a[href=?]", logout_path #And logout should be present
    assert_select "a[href=?]", chef_path(@chef) #There should be a path to the chef page
    assert_select "a[href=?]", edit_chef_path(@chef) #And a path to the edit chef page
  end

end

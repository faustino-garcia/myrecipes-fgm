require "test_helper"

class ChefsTestingTest < ActionDispatch::IntegrationTest

  def setup
    @chef = Chef.create!(name:"Oropeza",email:"ChefOropeza@gmail.com",password:"password",password_confirmation:"password")
    @chef2 = Chef.create!(name: "Abril", email: "AbrilChef@example.com",
                    password: "password", password_confirmation: "password")
  end

  test "should get chefs listing" do
    get chefs_path
    assert_template 'chefs/index'
    assert_select "a[href=?]", chef_path(@chef), text: @chef.name.capitalize
    assert_select "a[href=?]", chef_path(@chef2), text: @chef2.name.capitalize
  end

  test "should delete chef" do
    sign_in_as(@chef2,"password")
    get chefs_path
    assert_template 'chefs/index'
    assert_difference 'Chef.count',-1 do
      delete chef_path(@chef2)
    end
    assert_redirected_to chefs_path
    assert_not flash.empty?
  end

end

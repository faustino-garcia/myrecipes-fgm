require "test_helper"

class ChefsTestingTest < ActionDispatch::IntegrationTest

  def setup
    @chef = Chef.create!(name: "Christina", email: "ChrisChef@example.com",
                    password: "password", password_confirmation: "password")
    @chef2 = Chef.create!(name: "Abril", email: "AbrilChef@example.com",
                    password: "password", password_confirmation: "password")
  end

  test "should get chefs listing" do
    get chefs_path
    assert_template 'chefs/index'
    assert_select "a[href=?]", chef_path(@chef), text: @chef.name.capitalize
    assert_select "a[href=?]", chef_path(@chef2), text: @chef2.name.capitalize
  end

end

require "test_helper"

class ChefsEditTest < ActionDispatch::IntegrationTest
  
  def setup
    @chef = Chef.create!(name:"Oropeza",email:"ChefOropeza@gmail.com",password:"password",password_confirmation:"password")   
  end

  test "Reject an invalid edit" do
    get edit_chef_path(@chef)
    patch chef_path(@chef), params: {chef: {name: " ", email: "Oropeza@gmail.com"}}
    assert_template 'chefs/edit'
    assert_select 'h2.panel-title'
    assert_select 'div.panel-body'
  end

  test "Accept valid edit" do
    get edit_chef_path(@chef)
    patch chef_path(@chef), params: {chef: {name: "Francisco", email: "F_Oropeza@gmail.com"}}
    assert_redirected_to @chef  #To the show page of chef
    assert_not flash.empty?
    @chef.reload
    assert_match "Francisco", @chef.name 
    assert_match "f_oropeza@gmail.com", @chef.email
  end


end

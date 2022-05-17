require "test_helper"

class ChefsEditTest < ActionDispatch::IntegrationTest
  
  def setup
    @chef = Chef.create!(name:"Oropeza",email:"ChefOropeza@example.com",password:"password",password_confirmation:"password")   
    @chef2 = Chef.create!(name: "Oropeza2", email: "ChefOropeza2@example.com",password: "password", password_confirmation: "password")
    @admin_user = Chef.create!(name: "El_Admin2", email: "Admin2@example.com",password: "password", password_confirmation: "password",admin:true)
  end

  test "Reject an invalid edit" do
    sign_in_as(@chef,"password")
    get edit_chef_path(@chef)
    patch chef_path(@chef), params: {chef: {name: " ", email: "Oropeza@example.com"}}
    assert_template 'chefs/edit'
    assert_select 'h2.panel-title'
    assert_select 'div.panel-body'
  end

  test "Accept valid edit" do
    sign_in_as(@chef,"password")
    get edit_chef_path(@chef)
    patch chef_path(@chef), params: {chef: {name: "Francisco", email: "F_Oropeza@example.com"}}
    assert_redirected_to @chef  #To the show page of chef
    assert_not flash.empty?
    @chef.reload
    assert_match "Francisco", @chef.name 
    assert_match "f_oropeza@example.com", @chef.email
  end

  test "Accept edit attempt by admin user" do
    sign_in_as(@admin_user,"password")
    get edit_chef_path(@chef) 
    assert_template 'chefs/edit'
    patch chef_path(@chef), params: {chef: {name: "Francisco2", email: "F2_Oropeza@example.com"}}
    assert_redirected_to @chef  #To the show page of chef
    assert_not flash.empty?
    @chef.reload
    assert_match "Francisco2", @chef.name 
    assert_match "f2_oropeza@example.com", @chef.email
  end

  test "redirect edit attempt by a non-admin user" do
    sign_in_as(@chef2,"password")
    updated_name = "Pancho"
    updated_email = "Pancho@example.com"
    patch chef_path(@chef), params: {chef: {name: updated_name, email: updated_email}}
    assert_redirected_to chefs_path  #To the show page of chef
    assert_not flash.empty? 
    @chef.reload
    assert_match "Oropeza", @chef.name 
    assert_match "cheforopeza@example.com", @chef.email
  end

end

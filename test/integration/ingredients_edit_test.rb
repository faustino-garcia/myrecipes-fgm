require "test_helper"

class IngredientsEditTest < ActionDispatch::IntegrationTest
  
  def setup
    @admin = Chef.create!(name:"Admin",email:"Admin@gmail.com",password:"password",password_confirmation:"password",admin:true) 
    @recipe = Recipe.create(name:"Tacos de cochinita",description:"Deliciosos tacos de cochinita", chef: @admin)
    @ingredient = Ingredient.create!(name:"Pork meat")
    @recipe.ingredients << @ingredient  
  end

  test "reject invalid ingredient update" do
    sign_in_as(@admin,"password")
    get edit_ingredient_path(@ingredient)
    assert_template 'ingredients/edit'
    patch ingredient_path(@ingredient), params: {ingredient: {name:" "}}
    assert_template 'ingredients/edit'
    assert_select 'h2.panel-title'
    assert_select 'div.panel-body'
  end 

  test "successfully edit an ingredient" do
    sign_in_as(@admin,"password")
    get edit_ingredient_path(@ingredient)
    assert_template 'ingredients/edit'
    updated_name = "updated name"
    patch ingredient_path(@ingredient), params: {ingredient: {name:updated_name}}
    assert_redirected_to @ingredient
    assert_not flash.empty?
    @ingredient.reload
    assert_match updated_name, @ingredient.name
  end

end

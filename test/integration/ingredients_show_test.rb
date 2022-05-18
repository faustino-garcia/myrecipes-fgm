require "test_helper"

class IngredientsShowTest < ActionDispatch::IntegrationTest
  
  def setup
    @chef = Chef.create!(name:"Oropeza",email:"ChefOropeza2@gmail.com",password:"password",password_confirmation:"password") 
    @recipe = Recipe.create(name:"Tacos de cochinita",description:"Deliciosos tacos de cochinita", chef: @chef)
    @ingredient = Ingredient.create!(name:"Pork meat")
    @recipe.ingredients << @ingredient
  end

  test "should get ingredients show" do
    sign_in_as(@chef,"password")
    get ingredient_path(@ingredient)
    assert_template 'ingredients/show'
    assert_select "a[href=?]" , ingredient_path(@ingredient), @ingredient.name
    assert_match @ingredient.name, response.body
  end

end

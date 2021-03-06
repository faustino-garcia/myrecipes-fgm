require "test_helper"

class RecipesDeleteTest < ActionDispatch::IntegrationTest
  def setup
    @chef = Chef.create!(name:"Oropeza",email:"ChefOropeza@gmail.com",password:"password",password_confirmation:"password") 
    @recipe = Recipe.create(name:"Tacos de cochinita",description:"Deliciosos tacos de cochinita", chef: @chef)  
  end

  test "Sucessfully delete a recipe" do
    sign_in_as(@chef,"password")
    get recipe_path(@recipe)
    assert_template 'recipes/show'
    assert_select "a[href=?]" , recipe_path(@recipe), text: "Delete this recipe"
    assert_difference 'Recipe.count', -1 do
      delete recipe_path(@recipe)
    end  
    assert_redirected_to recipes_path 
    assert_not flash.empty?
  end



end

require "test_helper"

class RecipesEditTest < ActionDispatch::IntegrationTest
  
  def setup
    @chef = Chef.create!(name:"Oropeza",email:"ChefOropeza@gmail.com") 
    @recipe = Recipe.create(name:"Tacos de cochinita",description:"Deliciosos tacos de cochinita", chef: @chef)  
  end

  test "reject invalid recipe update" do
    get edit_recipe_path(@recipe)
    assert_template 'recipes/edit'
    patch recipe_path(@recipe), params: {recipe: {name:" ",description:"Some basic description for the test"}}
    assert_template 'recipes/edit'
    assert_select 'h2.panel-title'
    assert_select 'div.panel-body'
  end

  test "successfully edit a recipe" do
    
  end

end

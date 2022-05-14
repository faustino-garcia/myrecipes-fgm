require "test_helper"

class RecipesTest < ActionDispatch::IntegrationTest

  def setup
    #We are creating two recipes (with different methods)
    @chef = Chef.create!(name:"Oropeza",email:"ChefOropeza@gmail.com") 
    @recipe = Recipe.create(name:"Tacos de cochinita",description:"Deliciosos tacos de cochinita", chef: @chef)
    #Second Method
    @recipe2 = @chef.recipes.build(name:"Fruit salad",description:"Amazing fruit salad")
    @recipe2.save
  end

  test "should get recipes index" do
    get recipes_url
    assert_response :success
  end

  test "should get recipes listing" do 
    get recipes_path
    assert_template 'recipes/index'
    assert_match @recipe.name, @response.body
    assert_select "a[href=?]" , recipe_path(@recipe), @recipe.name
    assert_match @recipe2.name, @response.body
    assert_select "a[href=?]" , recipe_path(@recipe2), @recipe2.name
  end

  test "should get recipes show" do
    get recipe_path(@recipe)
    assert_template 'recipes/show'
    assert_match @recipe.name, response.body
    assert_match @recipe.description, response.body
    assert_match @chef.name, response.body
  end

end

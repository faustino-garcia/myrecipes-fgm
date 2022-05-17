require "test_helper"

class RecipesTest < ActionDispatch::IntegrationTest

  def setup
    #We are creating two recipes (with different methods)
    @chef = Chef.create!(name:"Oropeza",email:"ChefOropeza@gmail.com",password:"password",password_confirmation:"password") 
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
    sign_in_as(@chef,"password")
    get recipe_path(@recipe)
    assert_template 'recipes/show'
    assert_match @recipe.name, response.body
    assert_match @recipe.description, response.body
    assert_match @chef.name, response.body
    assert_select "a[href=?]" , edit_recipe_path(@recipe), text: "Edit this recipe"
    assert_select "a[href=?]" , recipe_path(@recipe), text: "Delete this recipe"
    assert_select "a[href=?]" , recipes_path, text: "Return to recipes listing"
  end

  test "create new valid recipe" do
    sign_in_as(@chef,"password")
    get new_recipe_path
    assert_template 'recipes/new'
    name_of_recipe = 'Meat lasagna'
    description_of_recipe = 'Go to an Italian restaurant and buy a delicious Meat Lasagna'
    assert_difference 'Recipe.count',1 do
      post recipes_path, params: { recipe: {name: name_of_recipe,description:description_of_recipe}}
    end
    follow_redirect!
    assert_match name_of_recipe.capitalize,response.body
    assert_match description_of_recipe,response.body
  end

  test "reject invalid recipe submissions" do
    get new_recipe_path
    assert_template 'recipes/new'
    assert_no_difference 'Recipe.count' do
      post recipes_path, params: { recipe: {name: " ", description: " "} }
    end
    assert_template 'recipes/new'
    assert_select 'h2.panel-title'
    assert_select 'div.panel-body'
  end

end

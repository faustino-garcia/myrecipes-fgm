require "test_helper"

class ChefsShowTest < ActionDispatch::IntegrationTest
  
  def setup
    #We are creating two recipes (with different methods)
    @chef = Chef.create!(name:"Oropeza",email:"ChefOropeza@gmail.com",password:"password",password_confirmation:"password") 
    @recipe = Recipe.create(name:"Tacos de cochinita",description:"Deliciosos tacos de cochinita", chef: @chef)
    #Second Method
    @recipe2 = @chef.recipes.build(name:"Fruit salad",description:"Amazing fruit salad")
    @recipe2.save
  end

  test "should get chefs show" do
    get chef_path(@chef)
    assert_template 'chefs/show'
    assert_select "a[href=?]" , recipe_path(@recipe), @recipe.name
    assert_select "a[href=?]" , recipe_path(@recipe2), @recipe2.name
    assert_match @recipe.description, response.body
    assert_match @recipe2.description, response.body
    assert_match @recipe.name, response.body
    assert_match @recipe2.name, response.body

  end

end

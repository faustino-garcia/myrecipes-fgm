require "test_helper"

class IngredientsListingTest < ActionDispatch::IntegrationTest

  def setup
    @ingredient = Ingredient.create!(name:"Pork meat")
  end

  test "should get ingredients listing" do
    get ingredients_path
    assert_template 'ingredients/index'
    assert_select "a[href=?]", ingredient_path(@ingredient), text: @ingredient.name.capitalize
  end

end

require 'test_helper'

class RecipeTest < ActiveSupport::TestCase
    def setup 
        @chef = Chef.create!(name: "Remy",email: "RemyTheRat@example.com",password:"password",password_confirmation:"password")
        @recipe = @chef.recipes.build(name: "tacos",description:"Tacos al pastor")
    end

    test "recipe without chef should be invalid" do
        @recipe.chef_id = nil
        assert_not @recipe.valid?
    end

    test "recipe should be valid" do
        assert @recipe.valid?
    end

    test "name should be present" do
        @recipe.name = " "
        assert_not @recipe.valid?
    end
    
    test "Description should be present" do
        @recipe.description = " "
        assert_not @recipe.valid?
    end

    test "Description shouldn't be less than 5 characters" do
        @recipe.description = "a" * 3
        assert_not @recipe.valid?
    end
    
    test "Description shouldn't be more than 5000 characters" do
        @recipe.description = "a" * 5001
        assert_not @recipe.valid?
    end
end
require 'test_helper'

class IngredientTest < ActiveSupport::TestCase

    def setup
        @ingredient = Ingredient.new(name:"Rice")
    end

    test "ingredient should be valid" do
        assert @ingredient.valid?
    end

    test "ingredient name should be present" do
        @ingredient.name = " "
        assert_not @ingredient.valid?
    end

    test "Ingredient name shouldn't be more than 35 characters" do
        @ingredient.name = "a" * 36
        assert_not @ingredient.valid?
    end

    test "Ingredient name should have more than 3 characters" do
        @ingredient.name = "a" * 2
        assert_not @ingredient.valid?
    end

end
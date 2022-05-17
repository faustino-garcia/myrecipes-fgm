require 'test_helper'

class CommentTest < ActiveSupport::TestCase

    def setup
        @chef = Chef.create!(name: "Remy",email: "RemyTheRat@example.com",password:"password",password_confirmation:"password")
        @recipe = @chef.recipes.build(name: "tacos",description:"Tacos al pastor")
        # @comment = Comment.new(description:"I tried your recipe, I burnt everything",chef:@chef,recipe:@recipe)
        @comment = @recipe.comments.build(description:"I tried your recipe, I burnt everything",chef:@chef)
    end

    # test "Comment should be valid" do
    #     assert @comment.valid?
    # end

    test "Comment description should be present" do
        @comment.description = " "
        assert_not @comment.valid?
    end

    test "comment description shouldn't be more than 140 characters" do
        @comment.description = "a" * 141
        assert_not @comment.valid?
    end

    test "comment description should have more than 4 characters" do
        @comment.description = "a" * 3
        assert_not @comment.valid?
    end

end
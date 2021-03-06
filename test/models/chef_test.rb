require 'test_helper'

class ChefTest < ActiveSupport::TestCase

    def setup
        @chef = Chef.new(name:"Gordon",email:"gordonRamsey@gmail.com",password:"password",password_confirmation:"password")
    end

    test "should be valid" do
        assert @chef.valid?
    end

    test "chef name should be present" do
        @chef.name = " "
        assert_not @chef.valid?
    end

    test "chef name shouldn't be more than 30 characters" do
        @chef.name = "a" * 31
        assert_not @chef.valid?
    end

    test "chef should have an email" do 
        @chef.email = " "
        assert_not @chef.valid?
    end

    test "chef email shouldn't be more than 255 characters" do
        @chef.email = "a" * 245 + "@example.com"
        assert_not @chef.valid?
    end

    test "email should accept correct format" do
        valid_emails = %w[user@example.com FAUS34@gmail.com M.first@yahoo.ca jhon+smith@co.uk.org] 
        #%w is a method to turn everything inside into an array
        valid_emails.each do |valids| 
            @chef.email = valids
            assert @chef.valid?, "#{valids.inspect} should be valid"
        end
    end

    test "should reject invalid email adresses" do
        invalid_emails = %w[faus34@example ElonMusk@example,com Tesla@gmail. Musk@spx+foo.com]
        invalid_emails.each do |invalids|
            @chef.email = invalids
            assert_not @chef.valid?, "#{invalids.inspect} should be valid"
        end
    end

    test "email should be unique and case insensitive" do
        duplicate_chef = @chef.dup #duo is method to duplicate chefs
        duplicate_chef.email = @chef.email.upcase
        @chef.save
        assert_not duplicate_chef.valid?
    end

    test "email should be lower case before hitting db" do
        mixed_email = "eLonMusk@Example.com"
        @chef.email = mixed_email
        @chef.save
        assert_equal mixed_email.downcase, @chef.reload.email
    end

    test "password should be present" do
        @chef.password = @chef.password_confirmation = " "
        assert_not @chef.valid?
    end

   test "password should be at least 5 characters" do
    @chef.password = @chef.password_confirmation = "x"*4
    assert_not @chef.valid?
   end 

   test "associated recipes should be destroyed" do
       @chef.save
       @chef.recipes.create(name:"testing destroy",description:"Tesing recipe")
       assert_difference 'Recipe.count', -1 do
           @chef.destroy
       end
   end

end
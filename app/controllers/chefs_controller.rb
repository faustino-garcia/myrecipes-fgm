class ChefsController < ApplicationController

    def new
        @chef = Chef.new
    end

    def index 
        @chefs = Chef.paginate(page: params[:page], per_page: 5)
    end

    def create
        @chef = Chef.new(chef_params)
        if @chef.save
            flash[:success] = "Welcome #{@chef.name} to MyRecipes App! "
            redirect_to chef_path(@chef)
        else 
            render 'new'
        end
    end

    def show
        @chef = Chef.find(params[:id])
        @chef_recipes = @chef.recipes.paginate(page: params[:page], per_page: 3)
        #A collection o 5 recipes per page, we are using this in order to show 3 recipes 
        #per page on the chefs recipes show
    end

    def edit 
        @chef = Chef.find(params[:id])
    end

    def update
        @chef = Chef.find(params[:id])
        if @chef.update(chef_params)
            flash[:success] = "Your account has been edited successfully"
            redirect_to @chef 
        else 
            render 'edit'
        end
    end

    def destroy
        @chef = Chef.find(params[:id])
        @chef.destroy
        flash[:danger] = "Chef and all associated recipes has been deleted!"
        redirect_to chefs_path
    end 

    private

    def chef_params
        params.require(:chef).permit(:name,:email,:password,:password_confirmation)
    end

end
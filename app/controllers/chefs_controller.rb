class ChefsController < ApplicationController

    before_action :set_chef, only: [:show,:edit,:update,:destroy]
    before_action :require_same_user, only: [:edit,:update,:destroy]
    before_action :require_admin, only: [:destroy]

    def new
        @chef = Chef.new
    end

    def index 
        @chefs = Chef.paginate(page: params[:page], per_page: 4)
    end

    def create
        @chef = Chef.new(chef_params)
        if @chef.save
            session[:chef_id] = @chef.id
            cookies.signed[:chef_id] = @chef.id
            flash[:success] = "Welcome #{@chef.name} to MyRecipes App! "
            redirect_to chef_path(@chef)
        else 
            render 'new'
        end
    end

    def show
        @chef_recipes = @chef.recipes.paginate(page: params[:page], per_page: 3)
        #A collection o 5 recipes per page, we are using this in order to show 3 recipes 
        #per page on the chefs recipes show
    end

    def edit     
    end

    def update
        if @chef.update(chef_params)
            flash[:success] = "Your account has been edited successfully"
            redirect_to @chef 
        else 
            render 'edit'
        end
    end

    def destroy
        if !@chef.admin?
        @chef.destroy
        flash[:danger] = "Chef and all associated recipes has been deleted!"
        redirect_to chefs_path
        end
    end 

    private

    def chef_params
        params.require(:chef).permit(:name,:email,:password,:password_confirmation)
    end

    def set_chef
        @chef = Chef.find(params[:id])
    end

    def require_same_user
        if current_chef != @chef and !current_chef.admin?
            flash[:danger]="You can only edit or delete your own account"
            redirect_to chefs_path
        end
    end

    def require_admin
        if logged_in? and !current_chef.admin?
            flash[:danger]="Only admin users can perform that action"
            redirect_to root_path
        end
    end


end
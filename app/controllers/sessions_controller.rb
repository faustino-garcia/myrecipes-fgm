class SessionsController < ApplicationController

    def new
        
    end

    def create
        #First we grab email and password of the login, we don't use an instance variable
        # @ because we wont use this on the views
        chef = Chef.find_by(email: params[:session][:email].downcase )
        #Verifying if the chef actually exists
        if chef && chef.authenticate(params[:session][:password])
            session[:chef_id] = chef.id #Storing an encrypted version of its ID in the cookies
            flash[:success] = "You have successfully loged in"
            redirect_to chef
        else 
            flash.now[:danger] = "There was something wrong with your login information"
            #we used flash.now because that way the message doesn't keep showing
            render 'new'
        end
    end

    def destroy
        session[:chef_id] = nil
        flash[:success] = "You have loged out"
        redirect_to root_path
    end

end
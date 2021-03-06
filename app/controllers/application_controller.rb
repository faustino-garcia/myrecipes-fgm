class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception

    helper_method :current_chef,:logged_in?

    def current_chef #Return the user object loged in
        @current_chef ||= Chef.find(session[:chef_id])  if session[:chef_id]
    end

    def logged_in?
        !!current_chef #!! turns anything into a true or false
    end

    def require_user
        if !logged_in?
            flash[:danger]="You must be logged in to perform that action"
            redirect_to root_path
        end
    end

end

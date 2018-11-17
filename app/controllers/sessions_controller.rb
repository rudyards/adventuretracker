include ApplicationHelper
class SessionsController < ApplicationController
    def new
        
    end

    def create
        user = User.find_by(username: params[:session][:username].downcase)
        if user && user.authenticate(params[:session][:password])
            log_in user
            remember user
            redirect_to "/"
        else
            flash.now[:danger] = 'Invalid username/password combination'
            render 'new'
        end
    end



    def destroy
        log_out if logged_in?
        redirect_to root_url
        flash[:success] = 'You have successfully logged out'
    end

end

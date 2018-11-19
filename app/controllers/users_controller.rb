include ApplicationHelper
class UsersController < ApplicationController


    def new
        @user = User.new
    end

    def create
        @user = User.new(user_params)

        if @user.save
          log_in @user
          flash[:success] = "Welcome to AdventureTracker"
          redirect_to "/"
        else
          render 'new'
        end
    end

    def edit

    end
    
    private

        def user_params
          params.require(:user).permit(:username, :email, :password,
                                       :password_confirmation)
        end

end

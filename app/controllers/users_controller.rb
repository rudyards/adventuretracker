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
      @user = User.find(params[:id])
    end

    def update
      @user = User.find(params[:id])
      if (@user.id != current_user.id)
          flash[:error] = "You don't have permission to do that"
          redirect_to '/'
      else 
        if @user.update_attributes(user_params)
          flash[:success] = "Profile updated"
          redirect_to '/'
        else
          render 'edit'
        end
      end
    end

    
    private

        def user_params
          params.require(:user).permit(:username, :email, :password,
                                       :password_confirmation, :timezone)
        end

end

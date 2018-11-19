include ApplicationHelper
class GamesController < ApplicationController

    before_action :logged_in_user

    def new
        @game = Game.new
    end

    def create
        @game = Game.new(game_params)
        @game.gm_id = current_user.id

        if @game.save
          flash[:success] = "Game created"
          redirect_to '/'
        else
          render 'new'
        end
    end

    def show
        @game = Game.find(params[:id])
    end

    def destroy
        Game.find(params[:id]).destroy
        flash[:success] = "Game deleted"
        redirect_to '/'
    end

    def edit
        @game = Game.find(params[:id])
    end

    def update
        @game = Game.find(params[:id])
        if @game.update_attributes(game_params)
          flash[:success] = "Profile updated"
          redirect_to '/'
        else
          render 'edit'
        end
    end


    private

        def game_params
          params.require(:game).permit(:name, :description, :gm_id)
        end

end

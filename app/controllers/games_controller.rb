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

    def delete
    end

    def update
    end


    private

        def game_params
          params.require(:game).permit(:name, :description, :gm_id)
        end

end

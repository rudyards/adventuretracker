class GamesController < ApplicationController

  include ApplicationHelper

  before_action :logged_in_user

    def new
        @game = Game.new
    end

    def create
        @game = Game.new(game_params)
        @game.gm_id = current_user.id
        @game.timezone = current_user.timezone

        if @game.save
          @membership = Membership.new(user_id: current_user.id, game_id: @game.id)

          if @membership.save
            flash[:success] = "Game created"
            redirect_to '/'
          else
            render 'new'
            flash[:error] = "Membership couldn't be created"
          end
        else
          render 'new'
        end
    end

    def show
        @game = Game.find(params[:id])        
        @gm = (@game.gm_id == current_user.id)
        @member = @game.users.where(id: current_user.id).first
        @knocked = @game.knocks.where(user_id: current_user.id).first
        @upcoming = @game.meetings.first
        @meetings = @game.meetings.future
        @meetings.each do |meeting|
          meeting.time.in_time_zone(current_user.timezone)
        end
    end

    def confirm
        @game = Game.find(params[:id])
    end

    def destroy
        @game = Game.find(params[:id])

        if (@game.gm_id == current_user.id)
          @game.destroy
          flash[:success] = "Game deleted"
          redirect_to '/'
        else
          flash[:error] = "You don't have permission to do that"
          redirect_to '/'
        end
    end

    def leave
        game = Game.find(params[:id])
        member = @game.memberships.where(user_id: current_user.id).first
        if member
          member.destroy
          flash[:success] = "You left the game"
          redirect_to '/'
        else
          flash[:error] = "You don't have permission to do that"
          redirect_to '/'
        end 
    end

    def kick
      game = Game.find(params[:id])
      user = User.find(params[:userid])
      member = game.memberships.where(user_id: user.id).first
      if member && (game.gm_id == current_user.id)
        member.destroy
        flash[:success] = "You've removed them from the game"
        redirect_to game
      else
        flash[:error] = "You can't do that"
        redirect_to game
      end
    end


    def edit
        @game = Game.find(params[:id])
    end

    def update
        @game = Game.find(params[:id])
        if (@game.gm_id == current_user.id)
          if @game.update_attributes(game_params)
            flash[:success] = "Profile updated"
            redirect_to '/'
          else
            render 'edit'
          end
        else
          flash[:error] = "You don't have permission to do that"
          redirect_to '/'
        end
    end

    def knock
        @game = Game.find(params[:id])    
        @knock = Knock.new(user_id: current_user.id, game_id: @game.id)   
        if @knock.save
          flash[:success] = "You've requested to join the game"
          redirect_to '/'
        else
          flash[:success] = "Request failed"
          redirect_to '/'
        end
    end

    def knockaccept
      knock = Knock.find(params[:knockid])
      thisgame = knock.game
      if knock.nil?
          flash[:error] = "Can't find that request"
          redirect_to '/'
      else
        if knock.game.gm_id != current_user.id
          flash[:error] = "You don't have permission to do that"
          redirect_to '/'
        else
          knock.game.memberships.create(user_id: knock.user_id)
          knock.destroy
          redirect_to thisgame
        end
      end
    end

    def knockreject
      knock = Knock.find(params[:knockid])
      thisgame = knock.game
      if knock.nil?
          flash[:error] = "Can't find that request"
          redirect_to '/'
      else
        if knock.game.gm_id != current_user.id
          flash[:error] = "You don't have permission to do that"
          redirect_to '/'
        else
          knock.destroy
          redirect_to this
        end
      end
    end

    private

        def game_params
          params.require(:game).permit(:name, :description, :gm_id, :timezone)
        end

end

include ApplicationHelper
class MeetingsController < ApplicationController

    def new
        @game = Game.find(params[:game_id])
        @meeting = Meeting.new(game_id: @game.id)
    end

    def create
        @meeting = Meeting.new(meeting_params)
        puts "\nGame id is #{@meeting.game_id}\n"

        if @meeting.save
            flash[:success] = "Added new meeting to this game"
            redirect_to '/'
        else
            render 'new'
        end
    end



    private

        def meeting_params
            params.require(:meeting).permit(:time, :duration, :place, :game_id)
          
        end

end

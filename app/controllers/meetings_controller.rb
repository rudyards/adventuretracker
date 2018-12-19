include ApplicationHelper
class MeetingsController < ApplicationController

    def new
        @game = Game.find(params[:game_id])
        @meeting = Meeting.new(game_id: @game.id)
    end

    def create
        @meeting = Meeting.new(meeting_params)
        puts "This is the time "
        Time.zone = @meeting.game.timezone
        @meeting.time = Time.zone.parse(@meeting.time.to_s)
        if (@meeting.game.gm_id == current_user.id)
            if params[:check]
                @proposed_time = pretty_time(@meeting.time)
                @game = @meeting.game
                render 'new'
            else 
                if @meeting.save
                    flash[:success] = "Added new meeting to this game"
                    redirect_to '/'
                else
                    render 'new'
                end
            end
        else
            flash[:error] = "You don't have permission to do that."
        end
    end

    def edit
        @meeting = Meeting.find(params[:id])
    end

    def update
        @meeting = Meeting.find(params[:id])
        if (@meeting.game.gm_id == current_user.id)
            if @meeting.update_attributes(meeting_params)
                if params[:check]
                    @proposed_time = pretty_time(@meeting.time)
                    @game = @meeting.game
                    render 'edit'
                else
                    flash[:success] = "Meeting edited"
                    redirect_to '/'
                end
            else
                render 'edit'
            end
        else
            flash[:error] = "You don't have permission to do that"
            redirect_to '/'
        end     
    end

    def destroy
        @meeting = Meeting.find(params[:id])
        if (@meeting.game.gm_id == current_user.id)
          @meeting.destroy
          flash[:success] = "Meeting deleted"
          redirect_to '/'
        else
            flash[:error] = "You don't have permission to do that"
            redirect_to '/'
        end
    end

    private

        def meeting_params
            params.require(:meeting).permit(:time, :duration, :place, :game_id)
          
        end

end

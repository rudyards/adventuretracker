include ApplicationHelper
class HomeController < ApplicationController

    def index
        if current_user
            @dming = current_user.gm_list
            @playing = current_user.play_list
        else
            @loggedout = true
        end


    end

end

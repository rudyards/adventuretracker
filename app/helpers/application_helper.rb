module ApplicationHelper

    def full_title(page_title = '')
        base_title = "AdventureTracker"
        if page_title.empty?
            base_title
        else
            page_title + " | " + base_title
        end
    end

    def current_user
        if (user_id = session[:user_id])
            @current_user ||= User.find_by(id: user_id)
            elsif (user_id = cookies.signed[:user_id])
            user = User.find_by(id: user_id)
        if user && user.authenticated?(cookies[:remember_token])
            log_in user
            @current_user = user
            end
        end
    end


    def logged_in?
        !current_user.nil?
    end

    def logged_in_user
        unless logged_in?
            redirect_to login_url, notice: "Please sign in."
        end
    end

    def pretty_time(thistime)    
        return thistime.strftime("%I:%M %p, %B %e, %Y")
    end


end

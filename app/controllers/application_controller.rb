class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public' #where our stylesheets go for css
    set :views, 'app/views'

    enable :sessions
    set :session_secret, "password_security"
  end

  get '/' do
    erb :welcome
  end

  helpers do

    def current_user
      @current_user ||= User.find_by_id(session[:user_id]) if session[:user_id]
    end

    def logged_in?
      !!current_user
    end

  end

end

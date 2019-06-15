class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public' #where our stylesheets go for css
    set :views, 'app/views'

    enable :sessions
    set :session_secret, 'password_security'
  end

  get '/' do
    erb :welcome
  end

end

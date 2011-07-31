class SessionsController < ApplicationController
  def new
    redirect_to "/auth/#{params[:provider]}"
  end

  def create
    auth = request.env['omniauth.auth']
    Rails.logger.debug( auth.inspect )
    unless @user = User.find_from_auth_hash(auth)
      # Create a new user or add an auth to existing user, depending on
      # whether there is already a user signed in.
      @user = User.create_from_auth_hash(auth, current_user)
    end

    # Log the authorizing user in.
    self.current_user = @user

    redirect_to root_url
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url
  end
end

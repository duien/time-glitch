class SessionsController < ApplicationController
  def create
    auth_info =  request.env['omniauth.auth']
    puts auth_info.inspect
    render :text => auth_info.inspect
  end
end

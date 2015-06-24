class SessionsController < Devise::SessionsController
  def create
    super
    Log.create(type: "User", description: "User with email #{current_user.email} signed in. IP Address - #{request.remote_ip}. Browser - #{request.env['HTTP_USER_AGENT']}")
  end

  def destroy
    Log.create(type: "User", description: "User with email #{current_user.email} signed out.")
    super
  end
end

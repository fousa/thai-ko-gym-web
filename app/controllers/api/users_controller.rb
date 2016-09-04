class Api::UsersController < Api::ApplicationController
  respond_to :json

  def index
    @users = User.order(:last_name, :first_name)
    respond_with @users
  end

  def active
    @users = User.active.order(:last_name, :first_name)
    respond_with @users
  end
end

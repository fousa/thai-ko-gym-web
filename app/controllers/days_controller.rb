class DaysController < ApplicationController
  authorize_resource :presence

  before_action :authenticate_user!
  before_action :set_day, only: [:show]

  def show
    @presences = Presence.for_day @current_day
  end

  private

  def set_day
    @current_day = Date.parse params[:id]
  rescue
    @current_day = Date.today
  end
end

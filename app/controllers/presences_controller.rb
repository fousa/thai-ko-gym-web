class PresencesController < ApplicationController
  authorize_resource

  before_action :authenticate_user!
  before_action :set_month, only: [:index]

  def index
    @presences = Presence.for_month(@current_month)
    render :index
  end

  private

  def set_month
    params[:month] = Date.today.beginning_of_month.strftime('%Y-%m-01') if params[:month].nil?

    @current_month = Date.parse(params[:month]).beginning_of_day
  rescue
    @current_month = Date.today.beginning_of_day
  end
end

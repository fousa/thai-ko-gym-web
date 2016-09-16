class DaysController < ApplicationController
  authorize_resource :presence

  before_action :authenticate_user!
  before_action :set_day, only: [:show]

  def show
    @presences = Presence.includes(:user).for_day @current_day
    respond_to do |format|
      format.html
      format.xlsx do
        response.headers['Content-Disposition'] = "attachment; filename=#{t('pages.days.export.filename', day: @current_day)}"
      end
    end
  end

  private

  def set_day
    @current_day = Date.parse params[:id]
  rescue
    @current_day = Date.today
  end
end

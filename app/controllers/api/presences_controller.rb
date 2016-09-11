module Api
  class PresencesController < Api::ApplicationController
    authorize_resource

    respond_to :json

    def create
      @presence = Presence.new(presence_params)
      @presence.registered_by = current_user
      @presence.save
      respond_with @presence
    end

    private

    def presence_params
      params.require(:presence).permit(:present_at, :user_id)
    end
  end
end

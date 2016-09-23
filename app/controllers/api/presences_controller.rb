module Api
  class PresencesController < Api::ApplicationController
    authorize_resource

    respond_to :json

    def create
      @presence = Presence.new(presence_params)
      @presence.registered_by = current_user
      @presence.save

      # When the presence is a duplicate, just remove the errors and make sure the
      # status code for accepted is returned.
      if @presence.duplicate?
        status = :accepted
        @presence.errors.clear
      end

      respond_with @presence, status: status
    end

    private

    def presence_params
      params.require(:presence).permit(:present_at, :user_id)
    end
  end
end

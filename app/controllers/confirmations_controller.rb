class ConfirmationsController < Devise::ConfirmationsController
  # Remove the first skip_before_filter (:require_no_authentication) if you
  # don't want to enable logged to access the confirmation page.
  skip_before_action :require_no_authentication, raise: false
  skip_before_action :authenticate_user!, raise: false

  # PUT /resource/confirmation
  def update
    with_unconfirmed_confirmable do
      @confirmable.attempt_set_params(params[:user])
      if @confirmable.valid? # and @confirmable.password_match?
        do_confirm
      else
        do_show
        @confirmable.errors.clear # so that we wont render :new
      end
    end

    return if @confirmable.errors.empty?
    render 'devise/confirmations/new'
  end

  # GET /resource/confirmation?confirmation_token=abcdef
  def show
    with_unconfirmed_confirmable do
      if @confirmable.no_password?
        do_show
      else
        do_confirm
      end
    end

    return if @confirmable.errors.empty?
    self.resource = @confirmable

    raise ActionController::RoutingError.new('Not Found') if resource.new_record?
    render 'devise/confirmations/new'
  end

  protected

  def with_unconfirmed_confirmable
    original_token = params[:confirmation_token]
    @confirmable = User.find_or_initialize_with_error_by(:confirmation_token, original_token)
    @confirmable.only_if_unconfirmed { yield } unless @confirmable.new_record?
  end

  def do_show
    @confirmation_token = params[:confirmation_token]
    @requires_password = true
    self.resource = @confirmable
    render 'devise/confirmations/new' # Change this if you don't have the views on default path
  end

  def do_confirm
    @confirmable.confirm
    set_flash_message :notice, :confirmed
    sign_in @confirmable, bypass: true
    redirect_to authenticated_root_path
  end
end

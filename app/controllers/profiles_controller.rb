class ProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user

  def show
    render :edit
  end

  def edit
  end

  def update
    if @user.update(update_params)
      sign_in @user, bypass: true
      redirect_to edit_profile_path, notice: t('pages.profiles.labels.notices.update')
    else
      render :edit
    end
  end

  private

  def set_user
    @user = current_user
  end

  def update_params
    params.require(:pilot).permit(:email, :first_name, :last_name, :password, :password_confirmation)
  end
end

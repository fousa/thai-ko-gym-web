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
      redirect_to edit_profile_path, notice: t('pages.profile.form.alerts.edit')
    else
      render :edit
    end
  end

  def update_password
    if @user.update_with_password(update_password_params)
      bypass_sign_in @user
      redirect_to edit_profile_path, notice: t('pages.profile.form.alerts.edit')
    else
      render :edit
    end
  end

  private

  def set_user
    @user = current_user
  end

  def update_password_params
    params.require(:user).permit(:current_password, :password, :password_confirmation)
  end

  def update_params
    params.require(:user).permit(:email, :first_name, :last_name, :sex, :birth_date, :phone_number, :address, :postalcode, :city, :country)
  end
end

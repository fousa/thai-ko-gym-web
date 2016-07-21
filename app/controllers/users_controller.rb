class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:edit, :update, :destroy, :invite]

  def index
    @users = User.all
  end

  def show
    redirect_to edit_user_path(params[:id])
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(user_params)
    @user.skip_confirmation_notification!
    if @user.save
      redirect_to edit_user_path(@user), notice: I18n.t('pages.users.form.alerts.new', name: @user.name)
    else
      render :new
    end
  end

  def update
    @user.skip_confirmation_notification!
    if @user.update(user_params)
      redirect_to edit_user_path(@user), notice: I18n.t('pages.users.form.alerts.edit', name: @user.name)
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    redirect_to users_url, notice: I18n.t('pages.users.form.alerts.delete', name: @user.name)
  end

  def invite
    @user.send_confirmation_instructions
    redirect_to edit_user_path(@user), notice: I18n.t('pages.users.form.alerts.invite', name: @user.name)
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :sex, :email, :birth_date, :category, :type, :rankings, :phone_number, :active, :comments, :address, :postalcode, :city, :country)
  end
end

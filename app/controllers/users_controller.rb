class UsersController < ApplicationController
  authorize_resource

  before_action :authenticate_user!
  before_action :set_user, only: [:show, :edit, :update, :destroy, :invite]
  before_action :set_users, only: [:index, :active, :inactive]

  helper_method :sort_column, :sort_direction

  def index
    @user_count = @users.count
    respond_to_index 'all'
  end

  def active
    @users = @users.active
    @user_count = @users.count
    respond_to_index 'active'
  end

  def inactive
    @users = @users.inactive
    @user_count = @users.count
    respond_to_index 'inactive'
  end

  def show
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

  def respond_to_index(type)
    respond_to do |format|
      format.html do
        @users = @users.page(params[:page])
        render :index
      end
      format.xlsx do
        @name = t("pages.users.export.name.#{type}")
        response.headers['Content-Disposition'] = "attachment; filename=#{t("pages.users.export.filename.#{type}")}"
        render :index
      end
    end
  end

  def set_users
    @users = User.order("#{sort_column} #{sort_direction}").search params[:search]
  end

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:first_name, :role, :last_name, :sex, :email, :birth_date, :category, :type, :rankings, :phone_number, :active, :comments, :address, :postalcode, :city, :country)
  end

  ### sorting

  def sortable_columns
    %w(first_name sex birth_date city active)
  end

  def sort_column
    sortable_columns.include?(params[:column]) ? params[:column] : 'first_name'
  end

  def sort_direction
    %w(asc desc).include?(params[:direction]) ? params[:direction] : 'asc'
  end
end

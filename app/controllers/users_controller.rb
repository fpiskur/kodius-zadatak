class UsersController < ApplicationController

  before_action :logged_in_user, only: [:edit, :update, :destroy]
  before_action :correct_user,   only: [:edit, :update, :destroy]
  before_action :admin_user,     only: [:custom_message]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      @user.send_activation_email
      flash[:info] = "Please check your email to activate your account."
      redirect_to root_url
    else
      render 'new', status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:success] = "Profile updated"
      redirect_to root_url
    else
      render 'edit', status: :unprocessable_entity
    end
  end

  def destroy
    user = User.find(params[:id])
    user.destroy
    flash[:success] = "Your account has been deleted"
    redirect_to root_url
  end

  def send_custom_message
    message = params[:message]
    users = User.all
    users.each do |user|
      if !user.admin?
        user.message = message
        user.send_custom_message_email
      end
    end
    flash[:info] = "Email sent to all present customers"
    redirect_to root_url
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                  :password_confirmation)
    end

    # Confirms the correct user
    def correct_user
      @user = User.find(params[:id])
      redirect_to root_url unless current_user?(@user)
    end

    # Confirms an admin user
    def admin_user
      redirect_to root_url unless current_user.admin?
    end

end

class UsersController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :find_user, only: %i[destroy update log_out status]

  def index
    users = User.select(:username, :logged_in)
    render json: users, status: :ok
  end

  def create
    user = User.new(user_params)
    user.save!
  rescue ActiveRecord::RecordInvalid
    render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
  end

  def destroy
    @user.destroy
    render json: { success: 'User has been deleted' }, status: :ok
  end

  def update
    @user.update!(username: params[:username])

    render json: @user, status: :ok
  rescue ActiveRecord::RecordInvalid
    render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
  end

  def log_in
    return render json: { error: 'Check username and password' } if params[:username].blank? || params[:password].blank?

    user = User.find_by!(username: params[:username], password: params[:password])

    user.update(logged_in: true)
    render json: { success: 'Successfully logged in ' }, status: :created
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'User not found' }, status: :not_found
  end

  def log_out
    if @user.logged_in == true
      @user.update(logged_in: false)
      render plain: 'Logged out successfully ', status: :ok
    else
      render plain: 'User should be logged in ', status: :unprocessable_entity
    end
  end

  def status
    render json: { status: @user.logged_in }, status: :ok
  end

  private

  def find_user
    render json: { error: 'ID required' } if params[:id].blank?
    @user = User.find_by!(id: params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'User not found' }
  end

  def user_params
    params.require(:user).permit(:username, :password, :password_confirmation)
  end
end

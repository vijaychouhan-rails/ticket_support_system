class Admin::UsersController < Admin::ApplicationController
  before_action :authenticate_admin!
  before_action :set_user, only: [:show, :update]
  before_action :check_params_for_user_type, only: [:create]

  def index
    @users = User.not_admin_users
  end

  def show
  end

  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.json { render partial: 'user', locals: { user: @user }, status: :created, location: [:admin, @user] }
      else
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.json { render partial: 'user', locals: { user: @user }, status: :ok, location: [:admin, @user] }
      else
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :email, :user_type, :password)
    end

    def check_params_for_user_type
      render json: { status: 'fail', message: 'required parameter user_type not found in request' } and return unless params[:user][:user_type].present?
    end
end

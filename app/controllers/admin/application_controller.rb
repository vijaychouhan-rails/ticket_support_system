class Admin::ApplicationController < ApplicationController
  before_action :authenticate_user!

  def authenticate_admin!
    unless current_user.admin?
      render json: { status: 'fail', message: 'You are not authorize to access this page' } and return
     end
  end
end

class Agent::ApplicationController < ApplicationController
  before_action :authenticate_user!

  def authenticate_agent!
    unless current_user.agent?
      render json: { status: 'fail', message: 'You are not authorize to access this page' } and return
     end
  end
end

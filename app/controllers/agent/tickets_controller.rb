class Agent::TicketsController < Agent::ApplicationController
  before_action :authenticate_agent!
  before_action :set_ticket, only: [:show, :update]

  def index
    @tickets = current_user.processed_tickets
    @unprocessed_tickets = Ticket.unprocessed_tickets
  end

  def show
  end

  def update
    respond_to do |format|
      if @ticket.update(ticket_params)
        format.json { render :show, status: :ok, location: @ticket }
      else
        format.json { render json: @ticket.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ticket
      @ticket = Ticket.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ticket_params
      params.require(:ticket).permit(:subject, :message, :user_id, :status)
    end
end

class TicketsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_ticket, only: [:show]

  def index
    @tickets = current_user.tickets
  end

  def show
  end

  def create
    @ticket = current_user.tickets.new(ticket_params)

    respond_to do |format|
      if @ticket.save
        format.json { render :show, status: :created, location: @ticket }
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

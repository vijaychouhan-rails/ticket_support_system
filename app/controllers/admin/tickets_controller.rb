class Admin::TicketsController < Admin::ApplicationController
  before_action :authenticate_admin!
  before_action :set_ticket, only: [:show, :update]

  def index
    @tickets = Ticket.all
  end

  def show
  end

  def create
    @ticket = Tickets.new(ticket_params)

    respond_to do |format|
      if @ticket.save
        format.json { render json: { result: true, status: 'created successfully' } }
      else
        format.json { render json: { errors: @ticket.errors.full_messages, result: false, status: 'errors occurs' } }
      end
    end
  end

  def update
    respond_to do |format|
      if @ticket.update(ticket_params)
        format.json { render json: { result: true, status: 'updated successfully' } }
      else
        format.json { render json: { errors: @ticket.errors.full_messages, result: false, status: 'errors occurs' } }
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
      params.require(:ticket).permit(:subject, :message, :user_id, :status, :processor_id)
    end
end

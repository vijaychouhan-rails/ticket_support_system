class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_ticket

  def create
    @comment = @ticket.comments.new(comment_params)

    respond_to do |format|
      if @comment.save
        format.json { render :show, status: :created }
      else
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    def set_ticket
      @ticket = Ticket.find(params[:ticket_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:user_id, :message, :ticket_id)
    end
end

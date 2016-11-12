json.extract! comment, :id, :user_id, :message, :ticket_id, :created_at, :updated_at
json.url ticket_url(comment.ticket, format: :json)
json.commentator_name comment.user.name
json.commentator_email comment.user.email

json.extract! ticket, :id, :subject, :message, :status, :user_id, :processor_id, :created_at, :updated_at
json.url ticket_url(ticket, format: :json)
json.owner_name ticket.user.name
json.owner_email ticket.user.email

json.extract! ticket, :id, :subject, :message, :status, :user_id, :processor_id, :created_at, :updated_at
json.url ticket_url(ticket, format: :json)
json.owner_name ticket.user.name
json.owner_email ticket.user.email
if ticket.processor
  json.processor_name ticket.processor.name
  json.processor_email ticket.processor.email
end

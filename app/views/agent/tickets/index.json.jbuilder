json.processed_tickets do
  json.array! @tickets, partial: 'agent/tickets/ticket', as: :ticket
end
json.unprocessed_tickets do
  json.array! @unprocessed_tickets, partial: 'agent/tickets/ticket', as: :ticket
end

json.tickets do
  json.array! @processed_tickets, partial: 'agent/tickets/ticket', as: :ticket
  json.array! @unprocessed_tickets, partial: 'agent/tickets/ticket', as: :ticket
end
json.result true

json.data do
  json.partial! "tickets/ticket", ticket: @ticket
  json.comments do
    json.array! @ticket.comments, partial: 'comments/comment', as: :comment
  end
end
json.result true

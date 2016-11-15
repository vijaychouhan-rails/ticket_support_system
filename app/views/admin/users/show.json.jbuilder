json.data do
  json.partial! "admin/users/user", user: @user
  if @user.customer?
    json.tickets do
      json.array! @user.tickets, partial: 'tickets/ticket', as: :ticket
    end
  end
  if @user.agent?
    json.processed_tickets do
      json.array! @user.processed_tickets, partial: 'tickets/ticket', as: :ticket
    end
  end
end
json.result true

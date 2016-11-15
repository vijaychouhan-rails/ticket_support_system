json.users do
  json.array! @users, partial: 'admin/users/user', as: :user
end
json.result true

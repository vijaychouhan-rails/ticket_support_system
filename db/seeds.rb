# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Create admin user
admin_user = User.where(email: 'admin@admin.com').first_or_create!(password: 'AdminXYZ', name: 'Admin', user_type: 'admin')

# Create agent user
agent_user = User.where(email: 'agent@agent.com').first_or_create!(password: 'AgentXYZ', name: 'Agent', user_type: 'agent')

# Create customer user
customer_user1 = User.where(email: 'customer1@customer.com').first_or_create!(password: 'Customer1XYZ', name: 'Customer1', user_type: 'customer')

customer_user2 = User.where(email: 'customer2@customer.com').first_or_create!(password: 'Customer2XYZ', name: 'Customer2', user_type: 'customer')


(1..5).each do |i|
  Ticket.where(subject: "Subject1#{i}").first_or_create!(message: "Message1#{i}", user: customer_user1)
end

(1..5).each do |i|
  Ticket.where(subject: "Subject2#{i}").first_or_create!(message: "Message2#{i}", user: customer_user2)
end

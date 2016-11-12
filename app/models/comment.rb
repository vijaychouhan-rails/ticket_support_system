class Comment < ApplicationRecord

  # Associatons goes here
  belongs_to :user
  belongs_to :ticket

  # Validatin goes here
  validates_presence_of :user_id, :ticket_id, :message
end

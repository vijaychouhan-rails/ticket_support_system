class Ticket < ApplicationRecord

  # Associatons goes here
  belongs_to :user
  belongs_to :processor, class_name: "User", optional: true

  # Validation goes here
  validates_presence_of :user_id, :subject, :message, :status

  # Set the default status of a ticket
  after_initialize :defult_status

  enum status: { open: 'Open', work_in_progess: 'Work_in_progess', close: 'Close' }

  private
    def defult_status
      self.status = 'open'
    end
end

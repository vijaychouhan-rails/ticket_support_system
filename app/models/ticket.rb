class Ticket < ApplicationRecord

  # Associatons goes here
  belongs_to :user
  belongs_to :processor, class_name: "User", optional: true
  has_many :comments, dependent: :destroy

  # Validation goes here
  validates_presence_of :user_id, :subject, :message, :status

  # Set the default status of a ticket
  after_initialize :defult_status, :if => :new_record?

  enum status: { open: 'Open', work_in_progress: 'Work_in_progress', close: 'Close' }

  scope :unprocessed_tickets, -> { where("processor_id IS NULL") }

  private
    def defult_status
      self.status ||= 'open'
    end
end

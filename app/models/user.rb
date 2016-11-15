class User < ApplicationRecord
  # Include default devise modules.
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :trackable, :validatable
  include DeviseTokenAuth::Concerns::User

  # Associatons goes here
  has_many :tickets, dependent: :destroy
  has_many :processed_tickets, foreign_key: 'processor_id', dependent: :nullify
  has_many :comments, dependent: :destroy

  # Validation goes here
  validates_presence_of :name, :user_type

  # Set the default user type
  after_initialize :defult_user_type, :if => :new_record?

  # Define role of user
  enum user_type: { customer: 'Customer', agent: 'Agent', admin: 'Admin' }

  scope :not_admin_users, -> { where.not(user_type: :admin) }

  private
    def defult_user_type
      self.user_type = 'customer'
    end
end

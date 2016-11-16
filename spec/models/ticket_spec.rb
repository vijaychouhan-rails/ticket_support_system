require 'rails_helper'

RSpec.describe Ticket, type: :model do
  it { should belong_to(:user) }
  it { should belong_to(:processor) }
  it { should have_many(:comments).dependent(:destroy) }

  it { should validate_presence_of(:user_id) }
  it { should validate_presence_of(:subject) }
  it { should validate_presence_of(:message) }
  it { should validate_presence_of(:status) }

  it "should return unprocessed tickets" do
    customer = create(:user, :customer)
    tickets = create_list(:ticket, 5, user_id: customer.id)

    expect(Ticket.unprocessed_tickets).to eq tickets
  end
end

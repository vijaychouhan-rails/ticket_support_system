require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_many(:tickets).dependent(:destroy) }
  it { should have_many(:processed_tickets).dependent(:nullify) }
  it { should have_many(:comments).dependent(:destroy) }

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:user_type) }
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:password) }

  it "should return all users except admin users" do
    customer = create(:user, :customer)
    agent = create(:user, :agent)
    admin = create(:user, :admin)

    expect(User.not_admin_users).to match_array [customer, agent]
  end
end

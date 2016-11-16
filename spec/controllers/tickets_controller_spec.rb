require 'rails_helper'

RSpec.describe TicketsController, type: :controller do
  render_views
  let(:response_json){ JSON.parse(response.body) }

  before (:each) do
    @user= create(:user, :customer)
    allow_message_expectations_on_nil()
    sign_in @user

    auth_headers = @user.create_new_auth_token
    request.headers.merge!(auth_headers)
  end

  describe "GET index" do
    it 'should have status 200' do
      get :index, format: :json
      expect(response.status).to eq 200
    end

    it 'List of tickets as json format' do
      tickets = create_list(:ticket, 5, user: @user)
      get :index, format: :json

      expect(response_json["tickets"][0]["subject"]).to eq(tickets.first.subject)
      expect(response_json["result"]).to eq true
    end
  end

  describe "POST create" do
    it 'should create ticket' do
      post :create, format: :json, ticket: attributes_for(:ticket)

      expect(response_json["result"]).to eq true
    end

    it 'should not create ticket' do
      post :create, format: :json, ticket: attributes_for(:ticket, subject: "")

      expect(response_json["result"]).to eq false
      expect(response_json["errors"]).to eq ["Subject can't be blank"]
    end
  end

  describe "GET show" do
    it "should show ticket data" do
      agent = create(:user, :agent)
      ticket = create(:ticket, user_id: @user.id)

      comment = create(:comment, ticket_id: ticket.id, user_id: agent.id)

      get :show, format: :json, id: ticket.id

      expect(response_json["result"]).to eq true
      expect(response_json["data"]["subject"]).to eq ticket.subject
      expect(response_json["data"]["comments"][0]["message"]).to eq comment.message
    end
  end
end

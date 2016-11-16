require 'rails_helper'

RSpec.describe Admin::TicketsController, type: :controller do
    render_views
  let(:response_json){ JSON.parse(response.body) }

  before (:each) do
    @user= create(:user, :admin)
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
      customer = create(:user, :customer)
      tickets = create_list(:ticket, 5, user: customer)
      get :index, format: :json

      expect(response_json["tickets"][0]["subject"]).to eq(tickets.first.subject)
      expect(response_json["result"]).to eq true
    end
  end

  describe "POST create" do
    before(:each) do
      @customer = create(:user, :customer)
    end

    it 'should create ticket' do
      post :create, format: :json, ticket: attributes_for(:ticket, user_id: @customer.id)

      expect(response_json["result"]).to eq true
    end

    it 'should not create ticket' do
      post :create, format: :json, ticket: attributes_for(:ticket, user_id: @customer.id, subject: "")

      expect(response_json["result"]).to eq false
      expect(response_json["errors"]).to eq ["Subject can't be blank"]
    end
  end

  describe "PATCH update" do
    before(:each) do
      @ticket = create(:ticket)
    end

    it 'should update ticket' do
      patch :update, format: :json, id: @ticket.id, ticket: { status: 'work_in_progress'}

      expect(response_json["result"]).to eq true
    end

    it 'should not create ticket' do
      patch :update, format: :json, id: @ticket.id, ticket: { status: '' }

      expect(response_json["result"]).to eq false
      expect(response_json["errors"]).to eq ["Status can't be blank"]
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

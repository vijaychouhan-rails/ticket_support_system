require 'rails_helper'

RSpec.describe Admin::UsersController, type: :controller do
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

    it 'List of users as json format' do
      customers = create_list(:user,2 , :customer)
      agents = create_list(:user, 2, :agent)
      get :index, format: :json

      expect(response_json["users"][0]["name"]).to eq(customers.first.name)
      expect(response_json["result"]).to eq true
    end
  end

  describe "POST create" do
    it 'should create user' do
      post :create, format: :json, user: attributes_for(:user, :customer)

      expect(response_json["result"]).to eq true
    end

    it 'should not create user' do
      post :create, format: :json, user: attributes_for(:user, :customer, name: "")

      expect(response_json["result"]).to eq false
      expect(response_json["errors"]).to eq ["Name can't be blank"]
    end
  end

  describe "PATCH update" do
    before(:each) do
      @customer = create(:user, :customer)
    end

    it 'should update user' do
      patch :update, format: :json, id: @customer.id, user: { name: 'Test'}

      expect(response_json["result"]).to eq true
    end

    it 'should not create user' do
      patch :update, format: :json, id: @user.id, user: { name: '' }

      expect(response_json["result"]).to eq false
      expect(response_json["errors"]).to eq ["Name can't be blank"]
    end
  end

  describe "GET show" do
    it "should show user data" do
      customer = create(:user, :customer)
      ticket = create(:ticket, user_id: customer.id)

      get :show, format: :json, id: customer.id

      expect(response_json["result"]).to eq true
      expect(response_json["data"]["name"]).to eq customer.name
      expect(response_json["data"]["tickets"][0]["subject"]).to eq ticket.subject
    end
  end
end

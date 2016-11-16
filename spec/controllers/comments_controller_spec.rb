require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  render_views
  let(:response_json){ JSON.parse(response.body) }

  before (:each) do
    @user= create(:user, :customer)
    allow_message_expectations_on_nil()
    sign_in @user

    auth_headers = @user.create_new_auth_token
    request.headers.merge!(auth_headers)
  end

  describe "POST create" do
    before(:each) do
      @ticket = create(:ticket, user_id: @user.id)
    end

    it 'should create comment' do
      post :create, format: :json, ticket_id: @ticket.id, comment: attributes_for(:comment)

      expect(response_json["result"]).to eq true
    end

    it 'should not create comment' do
      post :create, format: :json, ticket_id: @ticket.id, comment: attributes_for(:comment, message: "")

      expect(response_json["result"]).to eq false
      expect(response_json["errors"]).to eq ["Message can't be blank"]
    end
  end
end

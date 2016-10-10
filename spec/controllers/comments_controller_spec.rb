require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  describe "comments#create action" do
    it "should allow users to create comments on grams" do
      g = FactoryGirl.create(:gram)
      user = FactoryGirl.create(:user)
      sign_in user
      post :create, gram_id: g.id, comment: { message: 'awesome gram' }
      expect(response).to redirect_to root_path
      expect(g.comments.length).to eq 1
      expect(g.comments.first.message).to eq "awesome gram"
    end

    it "should require a user to be logged in to comment on a gram" do
      g = FactoryGirl.create(:gram)
      post :create, gram_id: g.id, comment: { message: 'awesome gram' }
      expect(response).to redirect_to new_user_session_path
    end

    it "should return http status code of not found if the gram isn't found" do
      user = FactoryGirl.create(:user)
      sign_in user
      post :create, gram_id: 'WHAT', comment: { message: 'awesome gram' }
      expect(response).to have_http_status(:not_found)
    end
  end
end

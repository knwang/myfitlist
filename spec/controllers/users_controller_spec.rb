require 'spec_helper'

describe UsersController do
  describe "GET #new" do
    it "assigns a new user to @user" do
      get :new
      expect(assigns(:user)).to be_a_new(User)
    end

    it "renders the :new template" do
      get :new
      expect(response).to render_template :new
    end
  end

  describe "POST #create" do
    context "with valid attributes" do
      let(:valid_user) { Fabricate.attributes_for(:user) }

      it "saves the new user in the database" do
        expect{ post :create, user: valid_user }.to change(User, :count).by(1)
      end

      it "redirects to the root path" do
        post :create, user: valid_user
        expect(response).to redirect_to(root_path)
      end
    end

    context "with invalid attributes" do
      let(:invalid_user) { Fabricate.attributes_for(:invalid_user) }

      it "doesn't save the new user in the database" do
        expect{ post :create, user: invalid_user }.not_to change(User, :count)
      end

      it "re-renders the :new template" do
        post :create, user: invalid_user
        expect(response).to render_template :new
      end
    end
  end
end
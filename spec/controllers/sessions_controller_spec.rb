require 'spec_helper'

describe SessionsController do
  describe "GET #new" do
    it "renders the :new template" do
      get :new
      expect(response).to render_template :new
    end
  end

  describe "POST #create" do
    let!(:valid_user) { Fabricate(:user) }

    context "with the valid credentials" do
      it "puts the signed in user in the session" do
        post :create, email: valid_user.email, password: valid_user.password
        expect(session[:user_id]).to eq(valid_user.id)
      end

      it "redirects to the new planning page when the user doesn't create the planning of today" do
        post :create, email: valid_user.email, password: valid_user.password
        expect(response).to redirect_to(new_planning_path)
      end

      it "redirects to the planning show page when the user has created the planning of today" do
        planning = Fabricate(:planning, user_id: valid_user.id)
        post :create, email: valid_user.email, password: valid_user.password
        expect(response).to redirect_to(planning_path(planning))
      end
    end

    context "with the invalid credentials" do
      it "doesn't put the sign in user in the session"
      it "re-renders the :new template"
    end
  end
end
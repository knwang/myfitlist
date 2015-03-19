require 'spec_helper'

describe PlanningsController do
  describe "GET #new" do
    it "assigns a new Planning to @planning" do
      get :new
      expect(assigns(:planning)).to be_a_new(Planning)
    end

    it "renders the :new template" do
      get :new
      expect(response).to render_template :new
    end
  end

  describe "POST #create" do
    let(:user) { Fabricate(:user) }
    before { session[:user_id] = user.id }

    context "with valid attributes" do
      let(:valid_planning) { Fabricate.attributes_for(:planning, weight: 100.0) }

      it "saves a new planning in the database" do
        expect{
         post :create, planning: valid_planning
          }.to change(Planning, :count).by(1)
      end

      it "create a planning associated with the current user" do
        post :create, planning: valid_planning
        expect(Planning.first.user_id).to eq(user.id)
      end

      it "redirects to the planning show page" do
        post :create, planning: valid_planning
        valid_planning = Planning.find_by(weight: 100.0)
        expect(response).to redirect_to(planning_path(valid_planning))
      end
    end

    context "with invalid attributes" do
      let(:invalid_planning) { Fabricate.attributes_for(:invalid_planning) }

      it "doesn't save a new planning in the database" do
        expect{
         post :create, planning: invalid_planning
          }.not_to change(Planning, :count)
      end

      it "re-renders the :new template" do
        post :create, planning: invalid_planning
        expect(response).to render_template :new
      end
    end
  end

  describe "PATCH #update" do
    let(:planning) { Fabricate(:planning, weight: 60) }
    before { @planning_attr = Fabricate.attributes_for(:planning, weight: 70) }

    context "with valid attributes" do
      it "updates attributes of the planning in the database" do
        patch :update, id: planning.id, planning: @planning_attr
        planning.reload
        expect(planning.weight).to eq(70)
      end

      it "redirects to the planning show page" do
        patch :update, id: planning.id, planning: @planning_attr
        expect(response).to redirect_to(planning_path(planning))
      end
    end

    context "with invalid attributes" do
      before { @planning_attr.update(weight: 0) }

      it "doesn't update attributes of the planning in the database" do
        patch :update, id: planning.id, planning: @planning_attr
        planning.reload
        expect(planning.weight).to eq(60)
      end
      it "sets error messages"

      it "re-renders the planning show page" do
        patch :update, id: planning.id, planning: @planning_attr
        expect(response).to render_template :show
      end
    end
  end
end
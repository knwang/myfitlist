require 'spec_helper'

describe PlanningsController do
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
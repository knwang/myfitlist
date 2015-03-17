require 'spec_helper'

describe ItemsController do
  let(:planning) { Fabricate(:planning) }

  describe "GET #new" do
    it "assigns the requested planning to @planning" do
      get :new, planning_id: planning.id
      expect(assigns(:planning)).to eq(planning)
    end

    it "renders the :new template" do
      get :new, planning_id: planning.id
      expect(response).to render_template(:new)
    end
  end

  describe "POST #create" do
    context "with valid attributes" do
      let(:valid_item) { Fabricate.attributes_for(:item) }

      it "saves the new item in the database" do
        expect{
         post :create, planning_id: planning.id, item: valid_item
          }.to change(Item, :count).by(1)
      end

      it "creates a item associated the planning" do
        post :create, planning_id: planning.id, item: valid_item
        expect(Item.first.planning).to eq(planning)
      end

      it "redirects to the planning show page" do
        post :create, planning_id: planning.id, item: valid_item
        expect(response).to redirect_to(planning_path(planning))
      end
    end

    context "with invalid attributes" do
      let(:invalid_item) { Fabricate.attributes_for(:invalid_item) }

      it "doesn't save the new item in the database" do
        expect{
         post :create, planning_id: planning.id, item: invalid_item
          }.not_to change(Item, :count)
      end

      it "assigns the requested planning to @planning" do
        post :create, planning_id: planning.id, item: invalid_item
        expect(assigns(:planning)).to eq(planning)
      end

      it "re-renders the :new template" do
        post :create, planning_id: planning.id, item: invalid_item
        expect(response).to render_template(:new)
      end
    end
  end

  describe "PATCH #update" do
    let(:item) { Fabricate(:item, planning_id: planning.id) }
    before { @item_attr = Fabricate.attributes_for(:item, name: "窄距俯卧撑", duration: 20, result: 100, unit: "个")}

    context "with valid attributes" do
      it "updates attributes of the item in the database" do
        patch :update, planning_id: planning.id, id: item.id, item: @item_attr
        item.reload
        expect(item.name).to eq("窄距俯卧撑")
        expect(item.duration).to eq(20)
        expect(item.result).to eq(100)
        expect(item.unit).to eq("个")
      end

      it "redirects to the planning show page" do
        patch :update, planning_id: planning.id, id: item.id, item: @item_attr
        expect(response).to redirect_to(planning_path(planning.id))
      end
    end

    context "with invalid attributes" do
      before { @item_attr.update(name: nil) }

      it "doesn't update attributes of the item in the database" do
        patch :update, planning_id: planning.id, id: item.id, item: @item_attr
        item.reload
        expect(item.name).not_to eq(nil)
      end

      it "sets the error messages" do
        patch :update, planning_id: planning.id, id: item.id, item: @item_attr
        expect(flash[:danger]).not_to be_nil
      end

      it "re-renders the planning show page" do
        patch :update, planning_id: planning.id, id: item.id, item: @item_attr
        expect(response).to render_template :show
      end
    end
  end

  describe "DELETE #destroy" do
    let!(:item) { Fabricate(:item, planning_id: planning.id) }

    it "deletes the item" do
      expect{
       delete :destroy, planning_id: planning.id, id: item.id
        }.to change(Item, :count).by(-1)
    end

    it "redirects to the planning show page" do
      delete :destroy, planning_id: planning.id, id: item.id
      expect(response).to redirect_to(planning_path(planning))
    end

    it "does't delete the item that has be finished" do
      item = Fabricate(:item, planning_id: planning.id, finished: true)
      expect{
       delete :destroy, planning_id: planning.id, id: item.id
        }.not_to change(Item, :count)
    end

    it "does't delete the item that does not belong to the current planning" do
      other_planning = Fabricate(:planning)
      other_item = Fabricate(:item, planning_id: other_planning.id)
      expect{
       delete :destroy, planning_id: planning.id, id: other_item.id
        }.not_to change(Item, :count)
    end
  end
end
shared_examples "require_signed_in" do
  it "redirects to the sign in page" do
    action
    expect(response).to redirect_to(sign_in_path)
  end
end

shared_examples "show_new_planning" do
  it "redirects to the new planning page when the user doesn't create the planning of today" do
    action
    expect(response).to redirect_to(new_planning_path)
  end
end

shared_examples "show_user_today_planning" do
  it "redirects to the planning show page when the user has created the planning of today" do
    planning = Fabricate(:planning, user_id: current_user.id)
    action
    expect(response).to redirect_to(planning_path(planning))
  end
end
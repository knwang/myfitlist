require 'spec_helper'

describe User do
  it { should have_secure_password }

  it { should validate_presence_of(:email) }
  it { should allow_value('test@yahoo.cn').for(:email) }
  it { should_not allow_value('yahoo.cn').for(:email) }
  it { should validate_uniqueness_of(:email) }

  it { should validate_presence_of(:password) }
  it { should validate_length_of(:password).is_at_least(6).is_at_most(20) }

  it { should validate_presence_of(:full_name) }
  it { should validate_length_of(:full_name).is_at_least(3).is_at_most(20) }

  it { should have_many(:plannings) }

  describe "#today_planning" do
    let(:user) { Fabricate(:user) }

    it "returns the planning of today when the user has created the planning today" do
      planning = Fabricate(:planning, user_id: user.id)
      expect(user.today_planning).to eq(planning)
    end

    it "returns nil when the user doesn't create the planning today" do
      expect(user.today_planning).to be_nil
    end
  end
end
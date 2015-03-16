require 'spec_helper'

describe Planning do
  it { should have_many(:items).order("created_at ASC") }

  let(:planning) { Fabricate(:planning)}
  let(:unfinished_item1) { Fabricate(:item, planning: planning, finished: false) }
  let(:unfinished_item2) { Fabricate(:item, planning: planning, finished: false) }
  let(:finished_itme1) { Fabricate(:item, planning: planning, finished: true) }
  let(:finished_itme2) { Fabricate(:item, planning: planning, finished: true) }

  describe "#unfinished_items" do
    it "returns an array for the unfinished items" do
      expect(planning.unfinished_items).to match_array([unfinished_item1, unfinished_item2])
    end
  end

  describe "#finished_items" do
    it "returns an array for the finished items" do
      expect(planning.finished_items).to match_array([finished_itme1, finished_itme2])
    end
  end
end
require "spec_helper"

feature "User interacts with planning" do
  given(:janne) { Fabricate(:user) }

  context "user has not created today planning" do
    scenario "user creates today planning and records result" do
      sign_in(janne)
      expect_weight(nil)
      expect_link_not_to_be_seen('增加项目')

      create_planning_with_weight(80)
      expect_link_to_be_seen('增加项目')
      expect_content_not_to_be_seen('项目名称')

      new_item = { name: '慢跑', duration: 60, result: 7, unit: '公里', finished: 1 }

      add_item(new_item)
      expect_new_item_to_be_seen(new_item)

      item = Item.find_by(name: '慢跑')
      update_item_be_finished(item)
      expect_checkbox_of_finished_item_be_checked_and_disabled
    end
  end
  
  context "user has created today planning" do
    given!(:today_planning) { Fabricate(:planning, user: janne, weight: 100) }
    given!(:item) { Fabricate(:item, planning: today_planning, name: "平板支撑", duration: 20, result: 20, unit: "分钟") }

    scenario "user edits planning and records result" do
      sign_in(janne)
      expect_weight(100)
      expect_item_info('item_duration', 20)

      update_weight(today_planning, 99)
      expect_weight(99)

      update_item_be_finished(item)
      expect_checkbox_of_finished_item_be_checked_and_disabled
    end
  end

  def expect_weight(weight)
    weight = weight == nil ? nil : weight.to_s
    expect(find_field('体重').value).to eq(weight)
  end

  def expect_link_not_to_be_seen(link_text)
    expect(page).not_to have_link(link_text)
  end

  def expect_link_to_be_seen(link_text)
    expect(page).to have_link(link_text)
  end

  def create_planning_with_weight(weight)
    fill_in :planning_weight, with: weight
    click_button '保存'
  end

  def expect_content_not_to_be_seen(content_text)
    expect(page).not_to have_content(content_text)
  end

  def add_item(new_item)
    click_link('增加项目')
    fill_in :item_name, with: new_item[:name]
    fill_in :item_duration, with: new_item[:duration]
    fill_in :item_result, with: new_item[:result]
    fill_in :item_unit, with: new_item[:unit]
    click_button '新增'
  end

  def expect_new_item_to_be_seen(new_item)
    expect(find_field('item_duration').value).to eq("#{new_item[:duration]}")
    expect(find_by_id('item_finished').value).to eq("#{new_item[:finished]}")
  end

  def update_item_be_finished(item)
    check('item_finished')
    click_button "item_#{item.id}"
  end

  def expect_checkbox_of_finished_item_be_checked_and_disabled
    expect(find_by_id('item_finished').checked?).to eq('checked')
    expect(find_by_id("item_finished").disabled?).to eq("disabled")
  end

  def expect_item_info(info_id, info_value)
    expect(find_field(info_id).value).to eq("#{info_value}")
  end

  def update_weight(planning, weight)
    fill_in :planning_weight, with: weight
    click_button '保存'
    planning.reload
  end
end

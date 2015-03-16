class CreatePlannings < ActiveRecord::Migration
  def change
    create_table :plannings do |t|
      t.float :weight

      t.timestamps
    end
  end
end

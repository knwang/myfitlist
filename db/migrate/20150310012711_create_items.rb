class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :name
      t.integer :duration
      t.float :result
      t.string :unit
      t.boolean :finished, default: false
      t.integer :planning_id

      t.timestamps
    end
  end
end

class Planning < ActiveRecord::Base
  has_many :items, -> { order 'created_at ASC' }

  def unfinished_items
    items.where(finished: false)
  end

  def finished_items
    items.where(finished: true)
  end
end
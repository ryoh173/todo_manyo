class Task < ApplicationRecord

  STATUS_NAME_MAP = { '未着手': 0, '作業中': 1, '完了': 2 }
  enum status: STATUS_NAME_MAP
  
  scope :order_list, lambda { |directions|
    priority_dir, deadline_dir = directions
    priority_dir, deadline_dir = [priority_dir, deadline_dir].map do |x|
      %w[asc desc].include?(x) ? x : 'asc'
    end
    scope = current_scope || all
    scope.order({priority: priority_dir}, {deadline: deadline_dir})
  }
  
  private
  
  ransacker :status, formatter: proc { |v| STATUS_NAME_MAP[v.to_sym] } do |parent|
    parent.table[:status]
  end
end

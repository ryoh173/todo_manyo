class Task < ApplicationRecord
  scope :order_list, lambda { |directions|
    priority_dir, deadline_dir = directions
    priority_dir, deadline_dir = [priority_dir, deadline_dir].map do |x|
      %w[asc desc].include?(x) ? x : 'asc'
    end
    scope = current_scope || all
    scope.order({priority: priority_dir}, {deadline: deadline_dir})
  }
end

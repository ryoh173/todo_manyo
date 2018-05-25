class Task < ApplicationRecord

  STATUS_NAME_MAP = { '未着手': 0, '作業中': 1, '完了': 2 }
  PRIORITY_NAME_MAP = { '低': 0, '中': 1, '高': 2}
  enum status: STATUS_NAME_MAP
  enum priority: PRIORITY_NAME_MAP
  
  validates :title,    presence: true
  validates :status,   presence: true
  validates :priority, presence: true
  validate  :deadline_cannot_be_in_the_past, if: -> { deadline.present? }

  def deadline_cannot_be_in_the_past
    errors.add(:deadline, 'は現在日付以降の日時を設定してください。') if deadline < Time.current.beginning_of_day
  end
  
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

module TasksHelper
  # タスク一覧用のソートリンク
  # @param attr [:priority|:deadline]
  def tasks_sort_link(attr, ps = params)
    text = Task.human_attribute_name(attr)
    index = %i[priority deadline].index(attr) #配列に要素があればindexを返す

    sort_params = ps.permit(s: [])[:s] || %w[asc asc]
    s = sort_params[index]
    sort_params[index] = s == 'desc' ? 'asc' : 'desc'
    arrow = s == 'desc' ? '▼' : '▲'

    url = params.to_unsafe_h.merge(s: sort_params)

    link_to("#{text} #{arrow}", url)
  end
end

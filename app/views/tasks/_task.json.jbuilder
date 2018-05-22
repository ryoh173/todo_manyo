json.extract! task, :id, :title, :description, :deadline, :priority, :status, :created_at, :updated_at
json.url task_url(task, format: :json)

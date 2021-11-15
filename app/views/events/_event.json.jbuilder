json.ignore_nil!
json.extract! event, :id, :finished_at
json.name truncate(event.name)
json.content truncate(event.content)
json.user event.user, :name, :email

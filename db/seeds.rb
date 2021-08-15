Item.destroy_all
Event.destroy_all
User.destroy_all
Role.destroy_all

Role.create!(name: 'Пользователь', code: :default)

hash_users = 10.times.map do
  {
    name: FFaker::Internet.user_name[0...16],
    email: FFaker::Internet.safe_email,
    role_id: Role.find_by(code: :default).id
  }
end

users = User.create! hash_users

hash_events = 20.times.map do
  {
    name: FFaker::HipsterIpsum.paragraph,
    content: FFaker::HipsterIpsum.paragraphs,
    user_id: users.sample.id
  }
end

events = Event.create! hash_events
hash_items = 200.times.map do
  {
    name: FFaker::HipsterIpsum.paragraph,
    event_id: events.sample.id
  }
end
Item.create! hash_items
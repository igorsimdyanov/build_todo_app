# frozen_string_literal: true

Item.destroy_all
Event.destroy_all
User.destroy_all
Role.destroy_all
Comment.destroy_all

default_role = Role.create!(name: 'Пользователь', code: :default)
admin_role = Role.create!(name: 'Администратор', code: :admin)

# wm@example.org
admin_email = 'admin@example.com'
User.create! name: 'Администратор',
             email: admin_email,
             password: admin_email,
             role: admin_role

hash_users = 10.times.map do
  email = FFaker::Internet.safe_email

  {
    name: FFaker::Internet.user_name[0...16],
    email: email,
    password: email,
    role: default_role
  }
end

users = User.create! hash_users

hash_events = 20.times.map do
  {
    name: FFaker::HipsterIpsum.paragraph,
    content: FFaker::HipsterIpsum.paragraphs,
    user: users.sample
  }
end

events = Event.create! hash_events

hash_items = 200.times.map do
  {
    name: FFaker::HipsterIpsum.paragraph,
    event: events.sample
  }
end
Item.create! hash_items

def create_event(users, event, parent_id = nil)
  comment = Comment.create!(
             user: users.sample,
             content: FFaker::HipsterIpsum.paragraphs,
             commentable_id: event.id,
             commentable_type: event.class.to_s
           )
  create_tree_comments(comment, parent_id)

  comment
end

def create_tree_comments(comment, parent_id)
  tree_comments = [{
    parent_id: comment.id,
    child_id: comment.id
  }]
  if parent_id
    TreeComment.where(parent_id: parent_id).each do |tree|
      tree_comments << {
        parent_id: tree.parent_id,
        child_id: comment.id
      }
    end
  end
  TreeComment.create!(tree_comments.uniq)
end

# events.each do |event|
#   root = create_event(users, event)
#     create_event(users, event, root.id)
#     first = create_event(users, event, root.id)
#       create_event(users, event, first.id)
#     create_event(users, event, root.id)
# end

events.each do |event|
  root = create_event(users, event)
    create_event(users, event, root.id)
    first = create_event(users, event, root.id)
      create_event(users, event, first.id)
    create_event(users, event, root.id)
end

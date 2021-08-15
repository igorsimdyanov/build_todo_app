class User < ApplicationRecord
  validates :name, presence: true
  validates :name, length: { maximum: 16, minimum: 2 }
  validates :name, uniqueness: true
  scope :default, -> { where(role_id: Role.find_by(code: :default)) }
  scope :fresh, ->(created_at) { where('created_at > ?', created_at) }
  scope :default_fresh, ->(created_at) { default.fresh(created_at) }
end

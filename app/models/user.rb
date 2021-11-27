# == Schema Information
#
# Table name: users
#
#  id                                                           :bigint           not null, primary key
#  active(пользователь активен (true) или заблокирован (false)) :boolean          default(TRUE)
#  current_sign_in_at                                           :datetime
#  current_sign_in_ip                                           :string
#  email(Электронный адрес пользователя)                        :string
#  encrypted_password                                           :string           default(""), not null
#  events_count                                                 :integer
#  last_sign_in_at                                              :datetime
#  last_sign_in_ip                                              :string
#  name(Имя, которое используется для входа)                    :string
#  remember_created_at                                          :datetime
#  reset_password_sent_at                                       :datetime
#  reset_password_token                                         :string
#  sign_in_count                                                :integer          default(0), not null
#  created_at                                                   :datetime         not null
#  updated_at                                                   :datetime         not null
#  role_id(Роль пользователя)                                   :integer
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_name                  (name) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (role_id => roles.id)
#
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  before_destroy :log_before_destory
  after_destroy :log_after_destory
  before_validation :normalize_name, on: :create
  before_validation :normalize_email, if: Proc.new { |u| u.email.present? }
  before_validation :set_role, on: [ :create, :update ]

  has_many :events, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :commented_events,
           through: :comments,
           source: :commentable,
           source_type: :Event
  has_many :commented_users,
           through: :comments,
           source: :commentable,
           source_type: :User

  belongs_to :role
  validates :name, presence: true
  validates :name, length: { maximum: 16, minimum: 2 }
  validates :name, uniqueness: true
  scope :default, -> { where(role_id: Role.find_by(code: :default)) }
  scope :fresh, ->(created_at) { where('created_at > ?', created_at) }
  scope :default_fresh, ->(created_at) { default.fresh(created_at) }

  Role.find_each do |role|
    define_method "#{role.code}?" do
      role_id == role.id
    end
  end

  def active_for_authentication?
    super && active?
  end

  def attributes
    super.filter{ |k, _v| %w[name email].include? k }.merge(description: description)
  end

  def description
    "#{name} (#{email})"
  end

  private

  def log_before_destory
    Rails.logger.info "##### Собираемся удалить пользователя #{name} #####"
  end

  def log_after_destory
    Rails.logger.info "########### Пользователь #{name} удален ###########"
  end

  def normalize_name
    self.name = name&.downcase&.titleize
  end

  def normalize_email
    self.email = email&.downcase
  end

  def set_role
    self.role ||= Role.find_by(code: :default)
  end
end

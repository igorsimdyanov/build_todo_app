# == Schema Information
#
# Table name: comments
#
#  id                                               :bigint           not null, primary key
#  commentable_type                                 :string           not null
#  content(Содержимое комментария)                  :text
#  created_at                                       :datetime         not null
#  updated_at                                       :datetime         not null
#  commentable_id                                   :bigint           not null
#  user_id(Внешний ключ для связи с таблицей users) :bigint
#
# Indexes
#
#  index_comments_on_commentable  (commentable_type,commentable_id)
#  index_comments_on_user_id      (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Comment < ApplicationRecord
  belongs_to :commentable, polymorphic: true

  after_touch :log_comment

  private

  def log_comment
    Rails.logger.info '###########################################'
    Rails.logger.info updated_at
    Rails.logger.info '###########################################'
  end
end

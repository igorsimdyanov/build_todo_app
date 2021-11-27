# == Schema Information
#
# Table name: roles
#
#  id              :bigint           not null, primary key
#  code(Псевдоним) :string
#  name(Заголовок) :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class Role < ApplicationRecord
  has_many :users
end

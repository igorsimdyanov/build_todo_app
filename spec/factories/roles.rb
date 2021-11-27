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
FactoryBot.define do
  factory :role do
    sequence(:name) { |n| "name#{n}" }
    sequence(:code) { |n| "code#{n}" }
  end
end

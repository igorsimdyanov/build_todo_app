FactoryBot.define do
  factory :event do
    name { "MyString" }
    content { "MyText" }
    done { false }
    user
    finished_at { "2022-02-04 20:11:23" }
  end

  factory :event_wrong, parent: :event do
    name { nil }
    user { nil }
  end
end

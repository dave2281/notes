FactoryBot.define do
  factory :note do
    association :user
    title { "Test Note" }
    text { "This is a test note." }
    tags { "#tag1 #tag2 #tag3" }
    color { "blue" }
  end
end

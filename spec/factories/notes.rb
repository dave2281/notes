FactoryBot.define do
  factory :note do
    title { "Sample Title" }
    text { "Sample text for the note." }
    tags { "sample, test" }
    color { "blue" }
    association :user
  end
end

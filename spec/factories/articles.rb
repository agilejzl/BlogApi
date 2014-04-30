# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :article do
    title { Faker::Name.name }
    content "MyText"
    author_id 1
  end
end

FactoryGirl.define do
  factory :comment do
    post
    sequence(:text) { |n| "text #{n}" }
  end
end
FactoryGirl.define do
  factory :post do
    title 'Example post'
    user
    text 'This is an example post'
  end
end
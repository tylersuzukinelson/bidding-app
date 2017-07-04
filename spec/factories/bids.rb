FactoryGirl.define do
  factory :bid do
    association :auction, factory: :auction
    bid { [96, 34, 44, 12, 18, 111].sample }
  end
end

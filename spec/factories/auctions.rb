FactoryGirl.define do
  factory :auction do
  #   title "MyString"
  #   details "MyText"
  #   ends_on "2017-07-04"
  #   reserved_price "9.99"

    sequence(:title) {|n| Faker::Commerce.product_name + "#{n}"}
    details Faker::Hacker.say_something_smart
    ends_on "2017-07-04"
    reserved_price "9.99"
  end
end

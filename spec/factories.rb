FactoryBot.define do
  factory :user do
    sequence :email do |n|
      "dummyEmail#{n}@gmail.com"
    end
    password { "secretPassword" }
    password_confirmation { "secretPassword" }
  end

  factory :place do
    address { '595 S. Clinton St, Denver, CO 80247' }
    association :user
  end
end
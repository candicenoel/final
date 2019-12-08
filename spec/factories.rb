FactoryBot.define do
  factory :comment do
    
  end

  factory :user do
    sequence :email do |n|
      "dummyEmail#{n}@gmail.com"
    end
    password { "secretPassword" }
    password_confirmation { "secretPassword" }
  end

  factory :place do
    address { '595 S. Clinton St, Denver, CO 80247' }
    facility_maps { fixture_file_upload(Rails.root.join('spec', 'fixtures', 'picture.png').to_s, 'image/png') }
    association :user
  end
end
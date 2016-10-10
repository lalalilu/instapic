FactoryGirl.define do
  factory :comment do
    message "MyText"
    user_id 1
    gram_id 1
  end
  factory :user do
    sequence :email do |n|
      "dummyEmail#{n}@gmail.com"
    end
    password "secretPassword"
    password_confirmation "secretPassword"
  end

  factory :gram do
    message "hello"
    picture { fixture_file_upload(Rails.root.join('spec', 'fixtures', 'picture.jpg'), 'image/jpg') }
    association :user
  end
end

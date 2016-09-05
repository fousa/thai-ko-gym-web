FactoryGirl.define do
  factory :presence do
    present_at Time.now

    user
    association :registered_by, factory: :user
  end
end

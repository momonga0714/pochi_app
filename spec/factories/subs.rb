FactoryBot.define do

  factory :sub do
    sub_name          {Faker::Name.name}
    genre_id           {"1"}
    type_id            {"1"}
    user_id            {"1"}
    after(:build) do |sub|
      sub.resipi_images << build(:resipi_image, sub: sub)
    end
    user
  end
end
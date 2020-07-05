FactoryBot.define do

  factory :soop do
    soop_name          {Faker::Name.name}
    genre_id           {"1"}
    type_id            {"1"}
    user_id            {"1"}
    after(:build) do |soop|
      soop.resipi_images << build(:resipi_image, soop: soop)
    end
    created_at { Faker::Time.between(from: DateTime.now - 2, to: DateTime.now) }
    user
  end
end
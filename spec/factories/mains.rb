FactoryBot.define do

  factory :main do
    main_name          {Faker::Name.name}
    genre_id           {"1"}
    type_id            {"1"}
    user_id            {"1"}
    after(:build) do |main|
      main.resipi_images << build(:resipi_image, main: main)
    end
    created_at { Faker::Time.between(from: DateTime.now - 2, to: DateTime.now) }
    user
  end
end
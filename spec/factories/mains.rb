FactoryBot.define do

  factory :main do
    main_name          {"麻婆豆腐"}
    genre_id           {"1"}
    type_id            {"1"}
    user_id            {"1"}
    after(:build) do |main|
      main.resipi_images << build(:resipi_image, main: main)
    end
  end
end
FactoryBot.define do

  factory :soop do
    soop_name          {"麻婆豆腐"}
    genre_id           {"1"}
    type_id            {"1"}
    user_id            {"1"}
    after(:build) do |soop|
      soop.resipi_images << build(:resipi_image, soop: soop)
    end
    user
  end
end
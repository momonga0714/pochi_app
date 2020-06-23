FactoryBot.define do

  factory :soop do
    soop_name          {"中華スープ"}
    menu_id            {"1"}
    comment            {"hogehoge"}
    genre_id           {"1"}
    type_id            {"1"}
    user_id            {"1"}
    after(:build) do |soop|
      soop.resipi_images << build(:resipi_image, soop: soop)
    end
  end
end
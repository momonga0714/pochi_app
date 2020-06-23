FactoryBot.define do

  factory :resipi_image do
    image               {File.open("#{Rails.root}/app/assets/images/3418554_s.jpg")}
  end
end